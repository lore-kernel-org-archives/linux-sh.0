From: =?UTF-8?B?44Kr44Kq44CA44Of44Oz44CA44OS44Kn44OD44OX?=  <cm-hiep@jinso.co.jp>
Date: Fri, 16 May 2014 01:08:12 +0000
Subject: Re: Ethernet bug at Upstream-v3.15-rcx on Lager.
Message-Id: <537564FC.4090905@jinso.co.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <53745E88.7040108@jinso.co.jp> <5374F753.70203@cogentembedded.com>
In-Reply-To: <5374F753.70203@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: netdev@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>

Hi Sergei

Thanks for your replying!

On 05/16/2014 02:20 AM, Sergei Shtylyov wrote:
> Hello.
>
> On 05/15/2014 10:28 AM, カオ　ミン　ヒェップ wrote:
>
>> I am Hiep from JINZAI SOLUTION (a Japanese Company).
>> Now, I am testing a upstream-v3.15-rc2 on Lager for Renesas RSO.
>> I found a problem about Ethernet Driver so I would like to report to 
>> you.
>> The problem is losing data when sending data by UDP:
>
>>      - From Lager board to PC:
>>      BANDWIDTH from 10M to 70M are good,  but they suddenly down 51.2
>> Mbits/sec at 80M
>>      and 57.8 Mbits/sec at 90 M and 64.2 Mbits/sec at 100M.
>
>    Do you mean 'iperf' tests here?
Yes, I used 'iperf' tool to test here.
And the results of test these test-cases on upstream-v3.15-rc5 as show 
below:
79.9 Mbits/sec at 80M, 81.5 Mbits/sec at 90 M and 75.1 Mbits/sec at 100M.

>
>>      - From PC to Lager board:
>>     Some time when the message of "sh-eth r8a7790-ether eth0: Receive 
>> FIFO
>> Overflow" occurs,
>>     some of datagrams will be lost as the logs show below:
>>      「$ iperf -c 172.16.1.36 -u -b 90M
>>      .....
>>      [  3] Server Report:
>>      [  3]  0.0-10.0 sec   108 MBytes  90.4 Mbits/sec   0.000 ms 
>> 36/76923
>> (0.047%)
>>      .....
>>      # iperf -s -u
>>      [ ID] Interval       Transfer     Bandwidth        Jitter 
>> Lost/Total
>> Datagrams
>>      sh-eth r8a7790-ether eth0: Receive FIFO Overflow
>>      [  3]  0.0-10.0 sec   108 MBytes  90.4 Mbits/sec   0.001 ms 
>> 36/76923
>> (0.047%)
>
>> Please review it when you have time.
>
>    Please try this patch:
>
> http://marc.info/?l=linux-netdev&m9602519809181
>
I have tested this patch on v3.15.0-rc5-00077-g14186fe, and results are 
the message of
"sh-eth r8a7790-ether eth0: Receive FIFO Overflow" has disappeared and 
sending datagrams is good.
(Bandwidth 10M to 100M: Test with 5/5 times by script and by hand are good)

Bests Regards.
Hiep.

