From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 04 Feb 2019 15:17:21 +0000
Subject: Re: [PATCH 7/7] sh_eth: offload RX checksum on SH7763
Message-Id: <a7938d32-24bf-146a-87ea-62b765b0337a@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <fc43bfa2-4312-b52b-a749-e3e43e242a95@cogentembedded.com>
 <e8ce7a88-b689-6114-66e4-c45a95087a1f@cogentembedded.com>
 <2859e252-a900-fdc7-bfd8-d1b7663174f2@landley.net>
In-Reply-To: <2859e252-a900-fdc7-bfd8-d1b7663174f2@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Landley <rob@landley.net>, netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
Cc: linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org

Hello!

On 02/04/2019 02:55 PM, Rob Landley wrote:

>> The SH7763 SoC manual describes the Ether MAC's RX checksum offload
>> the same way as it's implemented in the EtherAVB MACs...
>>
>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> I think this is the chip in the JCI N40 on my desk, how would I test this and
> tell it was working? (Is there an existing test program or...?)

   There are programs, yes. I used (rather old) netperf-2.2pl4 (I can send it to
you) running under perf (provided by the Poky rootfs). The details running netperf
on target are in the patch description #2; on host you just run netserver from that
same testsuite. The current netperf is maintained by HP on github but I was unable
to figure out how to build it quickly enough... :-)

> Also, can this be tested under QEMU's r2 board emulation?

   I have no idea, sorry.

> Rob

MBR, Sergei
