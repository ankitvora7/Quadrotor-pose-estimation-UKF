clear all
close all
clc
load('./imu/imuRawTest.mat')
timu = ts;
load('./cam/camTest.mat')
tcam = ts;
load('./vicon/viconRotTest.mat')
tvicon = ts;
UnscentedKalmanFilter(vals,rots,cam,timu,tvicon,tcam);