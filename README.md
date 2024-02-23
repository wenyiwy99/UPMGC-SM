# Unpaired Multi-View Graph Clustering with Cross-View Structure Matching

An official source code for paper Unpaired Multi-View Graph Clustering with Cross-View Structure Matching (UPMGC-SM), accepted by IEEE Transactions on Neural Networks and Learning Systems (TNNLS). Any communications or issues are welcomed. Please contact wenyiwy2022@163.com.

Multi-view clustering (MVC), which effectively fuses information from multiple views for better performance, has received increasing attention.
Most existing MVC methods assume that multi-view data are fully paired, which means that the mappings of all corresponding samples between views are pre-defined or given in advance. However, the data correspondence is often incomplete in real-world applications due to data corruption or sensor differences, referred as the data-unpaired problem (DUP) in multi-view literature. Although several attempts have been made to address the DUP issue, they suffer from the following drawbacks: 1) Most methods focus on the feature representation while ignoring the structural information of multi-view data, which is essential for clustering tasks; 2) Existing methods for partially unpaired problems rely on pre-given cross-view alignment information, resulting in their inability to handle fully unpaired problems; 3) Their inevitable parameters degrade the efficiency and applicability of the models. To tackle these issues, we propose a novel parameter-free graph clustering framework termed Unpaired Multi-view Graph Clustering framework with Cross-View Structure Matching (UPMGC-SM). Specifically, unlike the existing methods, UPMGC-SM effectively utilizes the structural information from each view to refine cross-view correspondences. Besides, our UPMGC-SM is a unified framework for both the fully and partially unpaired multi-view graph clustering. Moreover, existing graph clustering methods can adopt our UPMGC-SM to enhance their ability for unpaired scenarios.
Extensive experiments demonstrate the effectiveness and generalization of our proposed framework for both paired and unpaired datasets.

# Main function
- LSR+Ours/run.m
- GMC+Ours/run.m
- CoMSC+Ours/run.m

# Datasets
- 3Sources_fea.mat
- ORL_fea.mat

# Acknowledgements
Our code are partly based on the following GitHub repository. Thanks for their awesome works.
- [LSR](https://github.com/canyilu/Least-Squares-Regression-for-subspace-clustering)
- [GMC](https://github.com/cshaowang/gmc)
- [CoMSC](https://github.com/liujiyuan13/CoMSC-code_release)

# Citations
If you find this repository helpful, please cite our paper:
```
@article{wen2023unpaired,
  title={Unpaired multi-view graph clustering with cross-view structure matching},
  author={Wen, Yi and Wang, Siwei and Liao, Qing and Liang, Weixuan and Liang, Ke and Wan, Xinhang and Liu, Xinwang},
  journal={IEEE Transactions on Neural Networks and Learning Systems},
  year={2023},
  publisher={IEEE}
}
```
