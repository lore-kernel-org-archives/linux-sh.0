From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 07 Jun 2013 12:24:50 +0000
Subject: Re: [PATCH v5 0/8] sh_eth: deal with #ifdef'fery
Message-Id: <51B1D112.8030805@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201306062339.21353.sergei.shtylyov@cogentembedded.com> <20130606.160504.85747659460186927.davem@davemloft.net>
In-Reply-To: <20130606.160504.85747659460186927.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, nobuhiro.iwamatsu.yj@renesas.com, linux-sh@vger.kernel.org

Hello.

On 07-06-2013 3:05, David Miller wrote:

>>     This series of 8 patches are against Dave's 'net-next.git' repository.
>>     The series deals mostly with excess #ifdef'fery in the 'sh_eth' driver.
>> It doesn't yet get rid of all the #ifdef'fery but that's a matter of another
>> patchset. The last patch (it was almost in the middle of the series before),
>> contrariwise, adds one missing #ifdef...

>> [1/8] sh_eth: remove #ifdef around EDSR and GECMR bit definitions
>> [2/8] sh_eth: use EDSR_ENALL to set EDSR
>> [3/8] sh_eth: remove duplicate sh_eth_set_duplex() definitions
>> [4/8] sh_eth: remove SH_ETH_HAS_TSU
>> [5/8] sh_eth: add IRQ flags to 'struct sh_eth_cpu_data'
>> [6/8] sh_eth: remove #ifdef around sh_eth_select_mii()
>> [7/8] sh_eth: consolidate sh_eth_reset()
>> [8/8] sh_eth: enclose PM code into #ifdef CONFIG_PM

> All applied, thanks.

   Thanks to you for quick reaction.

> I think you should have two sets of const netdev_ops to cover the two
> cases, instead of writing to a non-const netdev_ops.  Could you send a
> follow-on patch which does that?

    Sigh, I told Iwamatsu-san to do it, but he failed to respin the 
patches. OK, I'll look into it later, when I have time.

> Thanks.

WBR, Sergei

