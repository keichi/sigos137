# 評価実験

提案手法の有効性を評価するために，タグ付けによるオーバーヘッドの大きさを評価す
る実験を行った．マイクロベンチマークを利用して，2ノード間での1対1通信の有効帯
域幅と遅延を，提案手法を使用する場合としない場合で計測し比較した．

## 評価環境

評価には，SDNスイッチ1台に接続した2台の計算ノードを使用した．表
\ref{tbl:switch-spec}にSDNスイッチの性能を，表\ref{tbl:node-spec}に計算ノード
の性能を示す．マイクロベンチマークにはOSU Micro Benchmark 5.1\cite{omb}を使用
した．

\begin{table}[htb]
    \centering
    \caption{SDNスイッチの性能}
    \medskip
    \label{tbl:switch-spec}
    \begin{tabular}{ll}
        \hline
        型番             & NEC \textsuperscript{\textregistered} UNIVERGE PF5240 \\
        SDN規格          & OpenFlow 1.0 \\
        Ports            & Gigabit Ethernet $\times$48 \\
        スイッチング容量 & 176Gbps \\
        転送性能         & 131Mpps \\ \hline
    \end{tabular}
\end{table}

\begin{table}[htb]
    \centering
    \caption{計算ノードの性能}
    \medskip
    \label{tbl:node-spec}
    \begin{tabular}{ll}
        \hline
        CPU          & Intel \textsuperscript{\textregistered} Xeon \textsuperscript{\textregistered} CPU E5520 $\times$ 2 \\
        メモリ       & 12GB (ECC) \\
        ネットワーク & Gigabit Ethernet \\
        OS           & Fedora 20 (Linux Kernel 3.19.8-100) \\ \hline
    \end{tabular}
\end{table}

有効帯域幅の計測にはOSU Micro Benchmarkに含まれる`osu_bw`ベンチマークを使用
し，ウィンドウサイズは64，繰り返し回数は500回とした．一方，遅延の計測には
`osu_latency`ベンチマークを使用し，繰り返し回数は50,000回とした．有効帯域幅と
遅延の計測の両方で，送信するメッセージサイズを1バイトから2Mバイトまで変化させ
た．

## 評価結果

有効帯域幅のベンチマーク結果を図\ref{fig:bw-overhead}に，遅延のベンチマーク結
果を図\ref{fig:latency-overhead}に示す．これら2つのプロットより，提案手法を使
用する場合としない場合で，実用上無視できる程度であると言える．

![2ノード間の有効帯域幅の比較\label{fig:bw-overhead}](bw.pdf)

![2ノード間の遅延の比較\label{fig:latency-overhead}](latency.pdf)

