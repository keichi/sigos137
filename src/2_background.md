# 技術課題

本節では，われわれが提案するSDN-MPIを概説し，本稿で取り扱う技術課題について記
す．そのために，まずSDN-MPIの構成技術であるSDN（Software-Defined Networking）
について説明する．

## SDN（Software-Defined Networking）

<!-- SDNの説明 -->
SDN（Software-Defined Networking）\cite{sdn}は近年高い関
心と注目を集めている新しいネットワークアーキテクチャである．
従来のネットワークアーキテクチャでは，
パケット制御の決定を担うコントロールプレーンと実際のパケット転送を
担うデータプレーンは，単一のネットワークデバイス上に実装されていた．SDNでは，
図\ref{fig:sdn-arch}に示すように，コントロールプレーンとデータプレーンを別々の
デバイスに分離する．SDNスイッチと呼ばれるネットワークデバイスはデータプレーン
の処理，SDNコントローラはネットワークのコントロールプレーンの処
理を担当する．

この機能分離により，
ネットワークがプログラム可能になること，動的な制御が
できること，集中制御ができると言った利点


![SDNのアーキテクチャ\label{fig:sdn-arch}](sdn-arch.pdf)

今日では，上述のSDNの一実装として，OpenFlow\cite{McKeown2008}が業界標準規格
となりつつある．OpenFlow対応スイッチは，フローの集合である「フローテーブル」を保持す
る．スイッチはパケットを受信すると，マッチするフローをフローテーブルから検索し
，フローのアクションを実行する．SDNコントローラは，ネットワーク内の全ての
OpenFlow対応スイッチのフローテーブルを操作することで，ネットワークを制御する．
OpenFlowでは，ネッ
トワークの制御を「フロー」という単位で行う．フローは，対象のパケットを限定する
ヘッダフィールドと，パケットに対して行う操作を定義するアクションから成る．
OpenFlow 1.0では，ヘッダフィールドとしてTCP/UDPポート番号，IPアドレス，MACアド
レスなど事前定義された12種類が使用可能である．アクションにはパケットを特定の
ポートへ転送する，パケットのヘッダを書き換える，パケットをドロップするなどの操
作がある．

\begin{table}[htbp]
    \centering
    \caption{フローテーブルの一例}
    \medskip
    \label{tbl:flow-table}
    \begin{tabular}{lllll}
        \hline
        \multicolumn{3}{c}{ヘッダフィールド}        & $\cdots$ & アクション \\ \hline
        宛先MAC           & 送信元IP   & 宛先IP     & $\cdots$ &            \\ \hline
                          & 192.0.2.12 & 192.0.2.34 &          & ポート1    \\
                          & 192.0.2.34 & 192.0.2.56 &          & ポート2    \\
        ff:ff:ff:ff:ff:ff &            &            &          & ポート1,2  \\
        72:42:c1:e4:75:8c &            &            &          & ドロップ
    \end{tabular}
\end{table}

## MPI (Message Passing Interface)

Message Passing Interface (MPI)
\cite{Gropp1999,MessagePassingInterfaceForum2015} is a standard specification
for inter-process communication libraries. Developers often utilize libraries
that conform to MPI while developing parallel distributed programs that run on
computer clusters. MPI is widely accepted in the HPC field and currently a de
facto standard for communication libraries. There are many MPI implementations
for various languages and platforms. Some of well-known open source
implementations are OpenMPI [18], MPICH [19] and MVAPICH [20]. HPC system
vendors often develop their own proprietary MPI library specifically optimized
for their platform. Thus, many developers could gain benefit if MPI
communication are accelerated using SDN.

MPI is based on a programming model called message-passing. Under this programming
model, multiple processes running in parallel cooperate together through the exchange of data
called messages. The API defined in MPI are designed so that the underlying interconnect
is hidden from the developers. This abstraction allows easier development of programs and
increases portability of the source code. For instance, processes are identified by a non-negative
integer called rank in MPI. Developers are able to use ranks instead of addresses in the underlying
network to specify the source and destination of a communication.

Table 2.2 shows some of the communication primitives defined in MPI. Communication primitives
defined in MPI can be generally categorized in two types: point-to-point communication
and collective communication. Point-to-point communication is a type of communication between
two processes. Representative examples of point-to-point communication MPI primitives
are MPI_Send and MPI_Recv. Collective communication is a communication where multiple
processes are involved. Some examples of collective communication are: MPI_Bcast (multiple
processes receive same data from one node), MPI_Reduce (one process reduces data from multiple
processes) and MPI_Allreduce (same as MPI_Reduce, but the reduced values are sent to
all participated processes).

## SDN-MPI実現のための技術課題

<!-- SDN-MPIのコンセプト -->
SDN-MPIは，計算ノード間を接続する相互結合網がSDNアーキテクチャを採用している
ことを前提としている．

2.1節で記載したネットワークフローの動的制御機能に着眼し、並列分散計算用メッ
セージライブラリMPIの。。に応用。。。　SDN-MPIの研究開発を推進してきた。
図 \ref{fig:sdn-mpi}にSDN-MPIのコンセプトを示す．SDN-MPIでは，MPIを利用するア
プリケーションから分散プロセス間の通信特性を抽出し，SDNを用いて通信特性に応じ
た最適なネットワーク制御を実現することを目的とする．われわれは，これまでの研究
開発により，SDN-MPIのアイディアを応用し，いくつかのMPI関数の高速化を実証した
\cite{Dashdavaa2013,Takahashi2014}．

しかし，これまでの研究では，個別のMPI関数を単独で実行することに主眼があり，未
だ実際のアプリケーションを稼働させるに至っていない．実際のMPIアプリケーションで
は，単一のアプリケーションが複数のMPI関数が実行する。その際、MPI関数の呼び出し
の際に与えられる，送信ランク・受信ランク・コミュニケータなどの引数もまた異なる。
SDNコントローラが，アプリケーションの通信要求に応じて適
切なネットワーク制御を行うためには，現在どのMPI関数が，どの引数で呼びだされて
いるかという情報をリアルタイムに把握する必要がある．本報告では以後，この情報を
MPI通信パターンと呼ぶ．

また，SDNコントローラはMPIアプリケーションに同期してネットワーク制御を実行しな
ければいけない．さらに，この同期のためのオーバーヘッドは低くなければいけない．

![SDN-MPI概念図\label{fig:sdn-mpi}](sdn-mpi.pdf)

提案手法では，タグに基づくパケット制御を効率的に実行できるようにするため，タグ
をMPIパケットのMACアドレスフィールドに書き込む方法を選択した．

提案手法では，MPI通信パターンに応じてパケットを動的にタグ付けするので，動的に
MPIパケットのMACアドレスを書き換える必要がある．

よって，タグ付け処理の前段階として，プロトコルハンドラに渡されたパ
ケットがMPIライブラリに由来するものか判定しなければいけない．

タグ付けカーネルモジュールが，MPIプロセス間でTCP接続が確立したことを
どのように検知するかという問題がある．

