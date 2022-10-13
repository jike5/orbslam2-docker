## Baseline Test

We use [TUM](http://vision.in.tum.de/data/datasets/rgbd-dataset/download ) dataset: 

We test rgbd mode and do not use ros, for the ros wrapper has some problem.

The metrics include cpu use rate and rmse



To calculate cpu and memory use rate:

ref: https://blog.csdn.net/shenyuflying/article/details/53244944

```
./monitor.sh
# Plot figure
gnuplot
set xdata time 
set timefmt "%Y-%m-%d_%H:%M:%S"
plot 'monitor.log' using 1:3 with linespoints linestyle 1
```

流量检测

```
iptraf
```



fr2_desk ape:

```
evo_ape tum -r full --align_origin -p ct_fr2_desk.txt gt_fr2_desk.txt
```

```
       max	0.108159
      mean	0.043998
    median	0.040635
       min	0.000000
      rmse	0.050748
       sse	5.598880
       std	0.025289
```

fr3_office ape:

```
       max	0.047842
      mean	0.021618
    median	0.021383
       min	0.000000
      rmse	0.022989
       sse	1.313822
       std	0.007821
```

