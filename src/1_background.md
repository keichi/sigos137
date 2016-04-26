# SDN-MPI

<!-- SDNの説明 -->
SDN-MPIは，計算ノード間を接続するの相互結合網がSDNアーキテクチャを採用している
ことを前提としている．SDN（Software-Defined Networking）\cite{sdn}は近年注目が
集まっている新しいネットワークアーキテクチャである．従来のネットワークアーキテ
クチャでは，パケット制御の決定を担うコントロールプレーンと実際のパケット転送を
担うデータプレーンは，単一のネットワークデバイス上に実装されていた．SDNでは，
図\ref{fig:sdn-arch}に示すように，コントロールプレーンとデータプレーンを別々の
デバイスに分離する．SDNスイッチと呼ばれるネットワークデバイスはデータプレーン
の処理のみを行い，SDNコントローラはネットワーク全体のコントロールプレーンの処
理を行う．SDNの利点としてネットワークがプログラム可能になること，動的な制御が
できること，集中制御ができることがあげられる．

\begin{figure}[htbp]
    \centering
    \includegraphics{sdn-arch.pdf}
    \caption{SDNのアーキテクチャ}
    \label{fig:sdn-arch}
\end{figure}

<!-- SDN-MPIのコンセプト -->
SDN-MPIのコンセプトを図 \ref{fig:sdn-mpi}に示す．SDN-MPIの基本的な考え方は，
MPIを利用するアプリケーションから分散プロセス間の通信特性を抽出し，SDNを用いて
通信特性に応じた最適なネットワーク制御を実行することにある．これまでの研究開発
により，いくつかのMPI関数の高速化を実証した．\cite{Dashdavaa2013,Takahashi2014}

\begin{figure}[htbp]
    \centering
    \includegraphics{sdn-mpi.pdf}
    \caption{SDN-MPIの概要}
    \label{fig:sdn-mpi}
\end{figure}

