function [ data_Bell, vid_rate_360, qual_360, mse_360] = tile_rate_psnr_ber( input_args )
%TILE_RATE_PSNR_BER Summary of this function goes here
%   Detailed explanation goes here
data_Bell=[0	13.91	51.68	18.73	16.77	52.70	13.81	24.75	54.90	7.42	35.98	56.97	4.09	52.90	58.94	2.33	80.19	60.92	1.38	125.11	63.01	0.80	197.87	63.95	0.48	302.55	67.76	0.28	
1	24.33	35.34	37.16	29.93	36.63	26.89	44.84	39.11	14.61	64.79	41.31	8.03	95.84	43.40	4.52	147.45	45.60	2.59	230.23	47.87	1.46	360.78	50.22	0.83	541.86	52.56	0.48	
2	25.78	33.94	45.94	32.36	35.27	33.27	49.81	37.81	17.97	74.42	40.09	9.73	111.79	42.30	5.35	171.91	44.56	3.05	264.52	46.80	1.74	411.97	49.15	1.01	618.48	51.43	0.59	
3	29.35	34.99	43.68	35.70	36.14	32.47	53.68	38.49	17.56	79.48	40.67	9.58	117.59	42.77	5.38	176.97	44.92	3.11	268.44	47.07	1.80	410.67	49.32	1.06	616.49	51.55	0.63	
4	25.85	34.67	43.73	31.50	35.94	31.98	46.55	38.40	17.22	69.16	40.59	9.40	103.53	42.72	5.26	157.58	44.86	3.05	244.27	47.01	1.76	380.98	49.26	1.03	576.95	51.45	0.61	
5	15.06	37.18	23.45	17.92	38.46	17.15	26.64	41.01	9.16	39.11	43.17	5.07	58.46	45.27	2.89	90.23	47.33	1.71	142.82	49.40	1.01	231.55	51.57	0.61	358.64	53.76	0.37	
6	14.97	37.70	20.38	17.60	39.03	14.97	25.55	41.55	8.04	36.68	43.80	4.38	53.72	45.98	2.44	82.04	48.09	1.43	128.86	50.30	0.82	207.99	52.66	0.47	316.08	54.99	0.28	
7	17.22	52.00	22.24	20.59	53.26	16.19	29.78	55.69	8.67	42.41	57.88	4.75	61.70	59.98	2.69	92.50	62.01	1.58	142.61	64.29	0.89	223.60	66.68	0.51	335.60	69.09	0.29	
8	23.41	35.73	46.28	29.22	36.83	34.35	45.35	38.98	19.22	68.62	41.04	10.53	104.33	43.04	5.93	161.13	45.22	3.41	253.64	47.38	1.94	399.19	49.62	1.11	608.82	51.88	0.64	
9	26.82	35.30	45.65	33.53	36.48	33.96	51.87	38.77	18.91	77.63	40.84	10.57	116.83	42.86	5.94	179.83	44.95	3.44	281.76	47.10	1.97	443.13	49.32	1.14	679.18	51.53	0.66	
10	26.84	34.37	46.02	33.31	35.54	34.67	51.99	37.96	19.03	77.89	40.07	10.59	117.69	42.18	5.94	180.83	44.34	3.43	280.83	46.51	1.96	437.06	48.75	1.14	663.59	50.94	0.68	
11	66.22	30.16	126.52	84.22	31.44	92.99	132.58	34.02	49.57	200.06	36.24	26.59	300.02	38.41	14.67	451.64	40.65	8.29	680.74	42.97	4.64	1021.42	45.44	2.56	1506.07	47.87	1.42	
12	41.27	32.50	72.55	50.73	33.81	53.10	76.71	36.33	28.76	114.31	38.56	15.41	169.82	40.72	8.50	255.67	42.90	4.86	389.78	45.15	2.76	600.66	47.54	1.56	898.83	49.85	0.89	
13	24.01	36.86	38.75	29.08	38.05	28.29	43.36	40.71	14.84	62.95	42.70	8.14	92.36	44.77	4.61	138.20	46.68	2.75	213.49	48.79	1.60	338.22	51.02	0.92	514.50	53.34	0.52	
14	15.03	38.49	19.05	17.90	39.98	13.66	26.00	42.40	7.59	37.33	44.52	4.21	54.63	46.56	2.39	82.52	48.47	1.44	130.42	50.62	0.83	210.81	52.90	0.49	323.86	55.21	0.29	
15	21.64	36.00	38.08	27.01	37.25	28.21	41.58	39.76	15.53	62.31	41.88	8.46	92.87	44.00	4.73	141.73	46.07	2.73	220.85	48.28	1.55	348.66	50.60	0.88	529.24	52.86	0.50	
16	26.87	33.08	66.63	34.01	34.22	50.53	54.72	36.55	28.32	84.51	38.71	15.51	130.61	40.89	8.49	203.06	43.11	4.79	318.60	45.32	2.70	499.15	47.61	1.53	760.89	49.79	0.89	
17	25.42	33.51	58.59	32.23	34.66	44.31	51.24	37.09	24.81	79.03	39.30	13.63	122.50	41.43	7.54	191.88	43.61	4.27	302.95	45.81	2.41	478.41	48.04	1.39	732.05	50.18	0.81	
18	25.75	33.80	54.37	32.29	34.94	40.40	50.17	37.33	22.10	75.86	39.47	12.19	115.96	41.60	6.78	180.15	43.80	3.85	280.90	45.98	2.18	439.90	48.23	1.26	668.90	50.38	0.75	
19	48.36	30.98	107.07	62.04	32.23	79.03	98.06	34.72	42.81	150.17	36.93	23.07	227.81	39.12	12.68	345.03	41.28	7.18	524.92	43.54	4.03	794.47	45.94	2.26	1176.53	48.23	1.29	
20	30.30	33.14	63.74	37.84	34.35	47.20	58.31	36.78	26.06	89.13	39.03	13.94	134.74	41.17	7.72	204.95	43.34	4.42	314.44	45.47	2.56	489.77	47.67	1.50	747.25	49.78	0.89	
21	27.99	34.03	53.14	34.29	35.33	39.34	51.88	37.92	20.98	76.28	40.14	11.26	113.16	42.27	6.28	171.68	44.37	3.64	265.90	46.46	2.11	418.91	48.65	1.23	641.84	50.76	0.73	
22	24.22	34.42	47.38	29.98	35.68	35.14	46.43	38.23	19.08	69.18	40.43	10.37	104.12	42.54	5.75	160.08	44.63	3.29	251.36	46.74	1.90	401.77	48.96	1.10	617.78	51.10	0.65	
23	21.58	34.48	47.11	27.10	35.71	35.41	43.16	38.15	19.71	65.35	40.30	10.83	99.92	42.44	6.00	154.71	44.59	3.42	242.45	46.75	1.95	386.81	49.02	1.12	594.39	51.20	0.65	
24	48.62	29.33	131.89	63.03	30.55	99.25	103.64	33.09	54.55	160.65	35.39	29.20	246.29	37.71	15.57	377.72	40.14	8.44	575.51	42.57	4.59	871.06	45.05	2.54	1285.35	47.38	1.44	
25	39.28	31.08	93.06	50.82	32.27	69.91	83.06	34.77	38.87	129.06	37.01	21.10	199.40	39.23	11.45	307.87	41.53	6.36	474.39	43.84	3.53	729.48	46.19	1.99	1091.36	48.41	1.15	
26	40.53	31.47	92.57	52.22	32.68	69.15	85.09	35.11	38.30	132.09	37.31	20.87	203.58	39.53	11.40	314.58	41.83	6.30	481.90	44.14	3.47	733.54	46.48	1.94	1091.94	48.74	1.11	
27	38.31	31.21	95.77	48.62	32.46	71.15	77.61	34.91	39.14	119.37	37.14	21.22	182.84	39.34	11.64	280.70	41.59	6.52	432.27	43.86	3.64	663.08	46.21	2.06	993.00	48.43	1.20	
28	41.32	31.03	95.37	52.50	32.27	70.74	83.39	34.78	38.45	127.96	37.02	20.73	194.36	39.26	11.25	295.85	41.53	6.30	452.63	43.81	3.54	690.93	46.14	2.02	1032.41	48.36	1.18	
29	46.13	31.46	89.53	59.01	32.76	66.01	94.80	35.35	35.49	144.05	37.61	19.10	217.42	39.85	10.32	327.73	42.15	5.69	492.07	44.47	3.12	735.92	46.86	1.74	1080.52	49.12	0.99	
30	49.12	31.21	95.85	63.13	32.51	71.09	101.35	35.08	38.81	154.66	37.38	20.83	234.11	39.61	11.28	355.07	41.94	6.19	534.04	44.27	3.39	802.93	46.67	1.87	1181.05	48.96	1.05	
31	53.02	29.36	133.90	68.80	30.62	99.42	112.94	33.19	54.36	174.81	35.49	29.12	267.62	37.82	15.54	408.38	40.22	8.43	619.84	42.66	4.58	934.86	45.18	2.51	1374.81	47.56	1.40	
32	41.83	30.00	117.26	55.08	31.22	88.27	92.86	33.73	48.61	147.06	36.03	26.04	228.14	38.34	13.89	353.08	40.73	7.57	542.74	43.14	4.13	827.54	45.60	2.29	1227.95	47.93	1.29	
33	45.82	30.38	113.72	60.00	31.59	85.47	100.06	34.07	47.95	157.76	36.31	25.92	246.04	38.55	14.04	381.49	40.88	7.73	587.74	43.22	4.27	896.87	45.62	2.37	1332.49	47.90	1.35	
34	50.67	30.51	115.57	66.20	31.74	86.76	110.34	34.21	48.12	174.21	36.43	26.10	270.46	38.67	14.08	417.11	41.02	7.69	632.92	43.36	4.21	953.30	45.78	2.33	1404.59	48.08	1.32	
35	37.17	31.21	88.88	48.05	32.40	67.29	78.04	34.81	37.74	121.47	36.99	20.87	187.35	39.17	11.50	290.35	41.46	6.40	447.09	43.77	3.56	686.09	46.17	2.00	1025.42	48.40	1.16	
36	44.22	30.31	116.22	57.88	31.41	88.33	96.37	33.81	50.16	153.09	35.96	27.93	240.87	38.12	15.58	380.18	40.41	8.65	596.57	42.79	4.73	917.18	45.26	2.59	1363.55	47.60	1.46	
37	44.57	31.61	73.61	56.68	32.93	54.22	89.77	35.46	29.67	134.94	37.70	16.12	201.52	39.93	8.84	302.77	42.21	4.96	455.94	44.49	2.80	688.47	46.80	1.62	1023.52	48.99	0.96	
38	48.48	30.85	89.01	62.09	32.15	65.71	98.59	34.75	35.80	147.89	37.00	19.47	221.97	39.24	10.60	335.58	41.53	5.92	508.00	43.87	3.29	771.65	46.27	1.86	1145.50	48.53	1.08	
39	49.70	29.57	124.98	64.32	30.83	92.73	105.63	33.45	50.03	162.45	35.80	26.40	247.12	38.10	14.13	376.50	40.50	7.73	573.29	42.92	4.23	869.14	45.39	2.34	1284.17	47.74	1.32	
40	21.33	33.81	49.33	26.83	35.04	37.30	42.57	37.51	20.99	65.15	39.67	11.64	100.35	41.82	6.43	156.93	43.99	3.66	248.34	46.17	2.09	396.74	48.40	1.21	613.13	50.52	0.71	
41	37.65	31.24	96.09	48.61	32.45	72.70	80.57	34.95	40.49	126.04	37.20	21.97	195.96	39.39	12.04	307.78	41.68	6.74	483.07	43.94	3.79	753.43	46.30	2.13	1135.98	48.56	1.22	
42	39.26	31.93	82.40	50.72	33.14	61.96	82.68	35.56	34.83	127.80	37.76	18.99	196.52	39.97	10.37	302.16	42.21	5.82	464.28	44.47	3.26	713.00	46.77	1.86	1069.50	48.97	1.08	
43	24.26	33.39	50.07	30.97	34.54	38.41	49.42	36.84	22.54	77.39	38.90	12.90	121.13	41.04	7.24	190.92	43.23	4.14	300.94	45.44	2.36	474.77	47.67	1.38	726.55	49.78	0.83	
44	24.64	31.47	92.07	32.54	32.53	72.31	57.15	34.75	43.34	96.47	36.79	24.82	160.79	38.96	13.78	265.63	41.21	7.68	432.66	43.53	4.22	686.23	45.95	2.31	1038.84	48.29	1.29	
45	26.04	34.10	43.23	31.77	35.30	32.05	48.36	37.70	17.90	71.66	39.86	9.97	106.86	41.97	5.62	163.08	44.12	3.28	254.78	46.22	1.93	406.06	48.40	1.14	630.62	50.49	0.69	
46	29.94	32.93	54.78	37.56	34.21	40.69	58.47	36.77	22.46	87.65	38.95	12.42	131.84	41.10	6.98	202.62	43.24	4.05	316.68	45.40	2.34	502.64	47.65	1.36	772.55	49.80	0.81	
47	27.79	32.20	70.04	35.64	33.42	52.71	57.77	35.94	29.03	89.49	38.15	15.81	138.06	40.38	8.61	213.51	42.61	4.86	334.29	44.84	2.75	524.78	47.13	1.57	799.90	49.31	0.92	
48	10.16	37.40	18.94	12.12	38.68	14.45	18.55	41.20	8.28	28.05	43.23	4.75	43.36	45.23	2.74	69.08	47.19	1.64	115.47	49.20	0.97	199.52	51.34	0.59	321.39	53.45	0.36	
49	16.06	35.18	33.13	19.67	36.42	25.42	31.21	38.81	14.44	48.35	40.91	8.08	75.74	42.99	4.57	119.68	45.08	2.67	194.59	47.14	1.57	320.55	49.27	0.95	505.31	51.30	0.58	
50	16.36	35.52	31.60	20.27	36.67	24.12	31.82	39.06	13.90	49.42	41.12	7.81	76.81	43.29	4.35	121.31	45.37	2.53	194.35	47.43	1.49	317.22	49.54	0.90	497.27	51.55	0.56	
51	20.63	35.16	32.30	25.95	36.43	24.16	41.21	38.92	13.33	62.25	41.12	7.33	93.80	43.24	4.12	142.69	45.36	2.39	218.68	47.48	1.40	343.48	49.64	0.85	524.32	51.66	0.53	
52	23.41	32.19	69.19	30.14	33.25	54.91	51.57	35.62	31.51	83.52	37.84	17.23	132.45	40.05	9.40	208.68	42.30	5.30	329.94	44.58	2.97	519.41	46.91	1.69	787.87	49.11	0.99	
53	21.07	34.34	44.19	25.98	35.51	33.27	40.39	37.96	18.41	61.48	40.15	10.04	95.03	42.26	5.61	149.56	44.38	3.25	239.25	46.50	1.90	386.67	48.63	1.14	606.68	50.70	0.69	
54	23.73	33.52	50.21	29.82	34.72	37.78	47.77	37.22	20.99	73.86	39.35	11.65	114.95	41.49	6.52	180.97	43.62	3.78	287.44	45.73	2.21	464.53	47.93	1.30	721.02	50.04	0.79	
55	15.04	35.45	30.01	18.47	36.69	22.87	28.95	39.15	12.94	44.28	41.25	7.32	68.63	43.33	4.15	107.28	45.40	2.43	172.05	47.46	1.43	283.54	49.58	0.86	449.89	51.62	0.53	
56	6.92	39.48	11.22	8.13	41.00	8.22	11.98	43.69	4.53	18.33	45.78	2.53	28.39	47.83	1.45	45.43	49.75	0.89	76.63	51.84	0.52	134.49	54.17	0.32	209.00	56.59	0.18	
57	8.38	38.40	14.48	10.08	39.69	10.95	15.14	42.46	6.16	23.67	44.48	3.45	36.85	46.48	1.96	59.33	48.55	1.17	98.12	50.62	0.69	168.02	52.88	0.41	264.16	55.16	0.24	
58	8.19	38.43	15.10	10.09	39.76	11.40	14.97	42.55	6.30	23.19	44.61	3.49	36.30	46.66	1.97	58.42	48.74	1.18	97.14	50.81	0.69	165.44	53.05	0.42	260.52	55.32	0.25	
59	8.97	38.97	12.52	10.82	40.28	9.18	15.95	43.02	4.99	23.87	45.18	2.78	36.11	47.30	1.62	56.05	49.28	1.00	91.24	51.31	0.60	153.98	53.48	0.37	240.64	55.76	0.22	
60	14.88	35.32	31.78	18.45	36.62	23.26	28.86	39.20	12.28	43.35	41.39	6.72	65.59	43.47	3.84	102.20	45.51	2.30	163.43	47.50	1.39	270.27	49.57	0.86	427.04	51.52	0.55	
61	13.87	35.44	31.09	17.00	36.67	23.18	26.48	39.30	12.26	40.70	41.56	6.63	63.45	43.70	3.71	101.75	45.80	2.18	166.59	47.90	1.30	276.09	50.01	0.79	438.27	52.07	0.49	
62	14.66	35.58	28.32	18.02	36.88	20.98	28.02	39.55	11.37	43.07	41.76	6.15	66.92	43.91	3.47	105.69	45.98	2.06	170.37	48.04	1.23	280.10	50.14	0.76	441.56	52.17	0.47	
63	10.35	37.86	15.42	12.43	39.28	11.26	18.45	42.01	6.07	26.96	44.19	3.40	41.10	46.27	1.97	64.72	48.26	1.21	105.51	50.27	0.73	178.43	52.41	0.45	281.76	54.55	0.27];

for i=1:1:64
    k=1;
    for j=2:3:28
        vid_rate_360(i,k)=data_Bell(i,j);
        qual_360(i,k)=data_Bell(i,j+1);
        mse_360(i,k)=data_Bell(i,j+2);
        k=k+1;
    end
end

figure
plot(vid_rate_360);
xlabel('Tile number');
ylabel('Bit rate (kbps)')
figure
plot(qual_360);
xlabel('Tile number');
ylabel('PSNR (dB)')

figure
plot(mse_360);
xlabel('Tile number');
ylabel('MSE')

end

