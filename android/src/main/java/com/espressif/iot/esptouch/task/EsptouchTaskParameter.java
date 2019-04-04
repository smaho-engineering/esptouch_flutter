package com.espressif.iot.esptouch.task;

public class EsptouchTaskParameter implements IEsptouchTaskParameter {

  private static int _datagramCount = 0;
  private long intervalGuideCodeMillisecond;
  private long intervalDataCodeMillisecond;
  private long timeoutGuideCodeMillisecond;
  private long timeoutDataCodeMillisecond;
  private int totalRepeatTime;
  private int esptouchResultOneLen;
  private int esptouchResultMacLen;
  private int esptouchResultIpLen;
  private int esptouchResultTotalLen;
  private int portListening;
  private int targetPort;
  private int waitUdpReceivingMilliseond;
  private int waitUdpSendingMillisecond;
  private int thresholdSucBroadcastCount;
  private int expectTaskResultCount;
  private boolean broadcast = true;

  public static class Builder {
    private Long intervalGuideCodeMillisecond;
    private Long intervalDataCodeMillisecond;
    private Long timeoutGuideCodeMillisecond;
    private Long timeoutDataCodeMillisecond;
    private Integer totalRepeatTime;
    private Integer esptouchResultOneLen;
    private Integer esptouchResultMacLen;
    private Integer esptouchResultIpLen;
    private Integer esptouchResultTotalLen;
    private Integer portListening;
    private Integer targetPort;
    private Integer waitUdpReceivingMillisecond;
    private Integer waitUdpSendingMillisecond;
    private Integer thresholdSucBroadcastCount;
    private Integer expectTaskResultCount;

    @Override
    public String toString() {
      StringBuffer sb = new StringBuffer();
      sb.append("intervalGuideCodeMillisecond ").append(intervalGuideCodeMillisecond).append(", ");;
      sb.append("intervalDataCodeMillisecond ").append(intervalDataCodeMillisecond).append(", ");
      sb.append("timeoutGuideCodeMillisecond ").append(timeoutGuideCodeMillisecond).append(", ");
      sb.append("timeoutDataCodeMillisecond ").append(timeoutDataCodeMillisecond).append(", ");
      sb.append("totalRepeatTime ").append(totalRepeatTime).append(", ");
      sb.append("esptouchResultOneLen ").append(esptouchResultOneLen).append(", ");
      sb.append("esptouchResultMacLen ").append(esptouchResultMacLen).append(", ");
      sb.append("esptouchResultIpLen ").append(esptouchResultIpLen).append(", ");
      sb.append("esptouchResultTotalLen ").append(esptouchResultTotalLen).append(", ");
      sb.append("portListening ").append(portListening).append(", ");
      sb.append("targetPort ").append(targetPort).append(", ");
      sb.append("waitUdpReceivingMillisecond ").append(waitUdpReceivingMillisecond).append(", ");
      sb.append("waitUdpSendingMillisecond ").append(waitUdpSendingMillisecond).append(", ");
      sb.append("thresholdSucBroadcastCount ").append(thresholdSucBroadcastCount).append(", ");
      sb.append("expectTaskResultCount ").append(expectTaskResultCount).append(".");
      return sb.toString();
    }

    private void validate() {
      // Check if everything is set. We want to set everything from Dart, so we
      // don't use default values (we could: private Integer value = 3;)
      // and we want to detect when we don't set a value
      if (intervalGuideCodeMillisecond != null &&
          intervalDataCodeMillisecond != null &&
          timeoutGuideCodeMillisecond != null &&
          timeoutDataCodeMillisecond != null &&
          totalRepeatTime != null &&
          esptouchResultOneLen != null &&
          esptouchResultMacLen != null &&
          esptouchResultIpLen != null &&
          esptouchResultTotalLen != null &&
          portListening != null &&
          targetPort != null &&
          waitUdpReceivingMillisecond != null &&
          waitUdpSendingMillisecond != null &&
          thresholdSucBroadcastCount != null &&
          expectTaskResultCount != null) {
        return;
      }
      throw new IllegalStateException("Must set all properties. Object: " + this);
    }

    public Builder setIntervalGuideCodeMillisecond(long v) {
      this.intervalGuideCodeMillisecond = v;
      return this;
    }

    public Builder setIntervalDataCodeMillisecond(long v) {
      this.intervalDataCodeMillisecond = v;
      return this;
    }

    public Builder setTimeoutGuideCodeMillisecond(long v) {
      this.timeoutGuideCodeMillisecond = v;
      return this;
    }

    public Builder setTimeoutDataCodeMillisecond(long v) {
      this.timeoutDataCodeMillisecond = v;
      return this;
    }

    public Builder setTotalRepeatTime(int v) {
      this.totalRepeatTime = v;
      return this;
    }

    public Builder setEsptouchResultOneLen(int v) {
      this.esptouchResultOneLen = v;
      return this;
    }

    public Builder setEsptouchResultMacLen(int v) {
      this.esptouchResultMacLen = v;
      return this;
    }

    public Builder setEsptouchResultIpLen(int v) {
      this.esptouchResultIpLen = v;
      return this;
    }

    public Builder setEsptouchResultTotalLen(int v) {
      this.esptouchResultTotalLen = v;
      return this;
    }

    public Builder setPortListening(int v) {
      this.portListening = v;
      return this;
    }

    public Builder setTargetPort(int v) {
      this.targetPort = v;
      return this;
    }

    public Builder setWaitUdpReceivingMilliseond(int v) {
      this.waitUdpReceivingMillisecond = v;
      return this;
    }

    public Builder setWaitUdpSendingMillisecond(int v) {
      this.waitUdpSendingMillisecond = v;
      return this;
    }

    public Builder setThresholdSucBroadcastCount(int v) {
      this.thresholdSucBroadcastCount = v;
      return this;
    }

    public Builder setExpectTaskResultCount(int v) {
      this.expectTaskResultCount = v;
      return this;
    }

    public EsptouchTaskParameter build(EsptouchTaskParameter taskParameter) {
      validate();
      taskParameter.intervalGuideCodeMillisecond = intervalGuideCodeMillisecond;
      taskParameter.intervalDataCodeMillisecond = intervalDataCodeMillisecond;
      taskParameter.timeoutGuideCodeMillisecond = timeoutGuideCodeMillisecond;
      taskParameter.timeoutDataCodeMillisecond = timeoutDataCodeMillisecond;
      taskParameter.totalRepeatTime = totalRepeatTime;
      taskParameter.esptouchResultOneLen = esptouchResultOneLen;
      taskParameter.esptouchResultMacLen = esptouchResultMacLen;
      taskParameter.esptouchResultIpLen = esptouchResultIpLen;
      taskParameter.esptouchResultTotalLen = esptouchResultTotalLen;
      taskParameter.portListening = portListening;
      taskParameter.targetPort = targetPort;
      taskParameter.waitUdpReceivingMilliseond = waitUdpReceivingMillisecond;
      taskParameter.waitUdpSendingMillisecond = waitUdpSendingMillisecond;
      taskParameter.thresholdSucBroadcastCount = thresholdSucBroadcastCount;
      taskParameter.expectTaskResultCount = expectTaskResultCount;
      return taskParameter;
    }
  }

  public EsptouchTaskParameter() {
    this(null);
  }

  public EsptouchTaskParameter(Builder builder) {
    if (builder == null) {
      builder = new Builder();
    }
    builder.build(this);
  }

  // the range of the result should be 1-100
  private static int __getNextDatagramCount() {
    return 1 + (_datagramCount++) % 100;
  }

  @Override
  public long getIntervalGuideCodeMillisecond() {
    return intervalGuideCodeMillisecond;
  }

  @Override
  public long getIntervalDataCodeMillisecond() {
    return intervalDataCodeMillisecond;
  }

  @Override
  public long getTimeoutGuideCodeMillisecond() {
    return timeoutGuideCodeMillisecond;
  }

  @Override
  public long getTimeoutDataCodeMillisecond() {
    return timeoutDataCodeMillisecond;
  }

  @Override
  public long getTimeoutTotalCodeMillisecond() {
    return timeoutGuideCodeMillisecond + timeoutDataCodeMillisecond;
  }

  @Override
  public int getTotalRepeatTime() {
    return totalRepeatTime;
  }

  @Override
  public int getEsptouchResultOneLen() {
    return esptouchResultOneLen;
  }

  @Override
  public int getEsptouchResultMacLen() {
    return esptouchResultMacLen;
  }

  @Override
  public int getEsptouchResultIpLen() {
    return esptouchResultIpLen;
  }

  @Override
  public int getEsptouchResultTotalLen() {
    return esptouchResultTotalLen;
  }

  @Override
  public int getPortListening() {
    return portListening;
  }

  // target hostname is : 234.1.1.1, 234.2.2.2, 234.3.3.3 to 234.100.100.100
  @Override
  public String getTargetHostname() {
    if (broadcast) {
      return "255.255.255.255";
    } else {
      int count = __getNextDatagramCount();
      return "234." + count + "." + count + "." + count;
    }
  }

  @Override
  public int getTargetPort() {
    return targetPort;
  }

  @Override
  public int getWaitUdpReceivingMillisecond() {
    return waitUdpReceivingMilliseond;
  }

  @Override
  public int getWaitUdpSendingMillisecond() {
    return waitUdpSendingMillisecond;
  }

  @Override
  public int getWaitUdpTotalMillisecond() {
    return waitUdpReceivingMilliseond + waitUdpSendingMillisecond;
  }

  @Override
  public void setWaitUdpTotalMillisecond(int waitUdpTotalMillisecond) {
    if (waitUdpTotalMillisecond < waitUdpReceivingMilliseond
        + getTimeoutTotalCodeMillisecond()) {
      // if it happen, even one turn about sending udp broadcast can't be
      // completed
      throw new IllegalArgumentException(
          "waitUdpTotalMillisecod is invalid, "
              + "it is less than waitUdpReceivingMilliseond + getTimeoutTotalCodeMillisecond()");
    }
    waitUdpSendingMillisecond = waitUdpTotalMillisecond
        - waitUdpReceivingMilliseond;
  }

  @Override
  public int getThresholdSucBroadcastCount() {
    return thresholdSucBroadcastCount;
  }

  @Override
  public int getExpectTaskResultCount() {
    return this.expectTaskResultCount;
  }

  @Override
  public void setExpectTaskResultCount(int expectTaskResultCount) {
    this.expectTaskResultCount = expectTaskResultCount;
  }

  @Override
  public void setBroadcast(boolean broadcast) {
    this.broadcast = broadcast;
  }
}
