From: Jose Abreu <Jose.Abreu@synopsys.com>
Date: Wed, 27 Jun 2018 14:44:10 +0000
Subject: Re: [PATCH net-next] net: stmmac: Add support for CBS QDISC
Message-Id: <222b400d-bc25-5854-370a-84d0d9056932@synopsys.com>
List-Id: <linux-sh.vger.kernel.org>
References: <daa3124702201f0d1c30da51f2a90cf432e39ba3.1530103308.git.joabreu@synopsys.com>
 <201806272221.VPR2vJhr%fengguang.wu@intel.com>
 <3780919b-c9ce-2ab6-be3a-376752c608ac@synopsys.com>
 <CAMuHMdUhQBpfZGk-18F8BxPqRzHX4GEEV-=4LZ9NeO=pm6bsyg@mail.gmail.com>
In-Reply-To: <CAMuHMdUhQBpfZGk-18F8BxPqRzHX4GEEV-=4LZ9NeO=pm6bsyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>, Jose.Abreu@synopsys.com
Cc: kbuild test robot <lkp@intel.com>, Linux-sh list <linux-sh@vger.kernel.org>, Rich Felker <dalias@libc.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, kbuild-all@01.org, netdev <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Joao.Pinto@synopsys.com, Vitor Soares <Vitor.Soares@synopsys.com>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, Alexandre Torgue <alexandre.torgue@st.com>

Hi Geert,

On 27-06-2018 15:36, Geert Uytterhoeven wrote:
> Hi Jose,
>
> On Wed, Jun 27, 2018 at 4:32 PM Jose Abreu <Jose.Abreu@synopsys.com> wrote:
>> ++ SH Maintainers
>> ++ SH ML
>>
>> Hi SH Maintainers,
>>
>> On 27-06-2018 15:15, kbuild test robot wrote:
>>> Hi Jose,
>>>
>>> I love your patch! Perhaps something to improve:
>>>
>>> [auto build test WARNING on net-next/master]
>>>
>>> url:    https://urldefense.proofpoint.com/v2/url?u=https-3A__github.com_0day-2Dci_linux_commits_Jose-2DAbreu_net-2Dstmmac-2DAdd-2Dsupport-2Dfor-2DCBS-2DQDISC_20180627-2D214704&d=DwIBAg&c=DPL6_X_6JkXFx7AXWqB0tg&r=WHDsc6kcWAl4i96Vm5hJ_19IJiuxx_p_Rzo2g-uHDKw&m=YIae3rrFzqYg_5b4eVIAXuyvT_EV0vKACS25rJugux8&s=qW5_vbinGt0OnyDfQ2wtKdb2ZGzCcLwq6Fmlaki61xw&e>>> config: sh-allyesconfig (attached as .config)
>>> compiler: sh4-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
>>> reproduce:
>>>         wget https://urldefense.proofpoint.com/v2/url?u=https-3A__raw.githubusercontent.com_intel_lkp-2Dtests_master_sbin_make.cross&d=DwIBAg&c=DPL6_X_6JkXFx7AXWqB0tg&r=WHDsc6kcWAl4i96Vm5hJ_19IJiuxx_p_Rzo2g-uHDKw&m=YIae3rrFzqYg_5b4eVIAXuyvT_EV0vKACS25rJugux8&s=4nNar4fgVZq0LjrPKIZP30nxVUY4yeu5QeyKbmlsu8A&e= -O ~/bin/make.cross
>>>         chmod +x ~/bin/make.cross
>>>         # save the attached .config to linux build tree
>>>         GCC_VERSION=7.2.0 make.cross ARCH=sh
>>>
>>> All warnings (new ones prefixed by >>):
>>>
>>>    In file included from ./arch/sh/include/generated/asm/div64.h:1:0,
>>>                     from include/linux/kernel.h:174,
>>>                     from include/linux/list.h:9,
>>>                     from include/linux/timer.h:5,
>>>                     from include/linux/workqueue.h:9,
>>>                     from include/net/pkt_cls.h:6,
>>>                     from drivers/net//ethernet/stmicro/stmmac/stmmac_tc.c:7:
>>>    drivers/net//ethernet/stmicro/stmmac/stmmac_tc.c: In function 'tc_setup_cbs':
>>>    include/asm-generic/div64.h:222:28: warning: comparison of distinct pointer types lacks a cast
>>>      (void)(((typeof((n)) *)0) = ((uint64_t *)0)); \
>>>                                ^
>>>>> drivers/net//ethernet/stmicro/stmmac/stmmac_tc.c:325:2: note: in expansion of macro 'do_div'
>>>      do_div(value, speed_div);
>>>      ^~~~~~
>>>    include/asm-generic/div64.h:222:28: warning: comparison of distinct pointer types lacks a cast
>>>      (void)(((typeof((n)) *)0) = ((uint64_t *)0)); \
>> I'm not seeing the reason for this warning as I'm using a 64 bit
>> var. I guess the warning is appearing only because its signed
>> [see source bellow]. Is this not supported?
> No, the first parameter of do_div() must be u64, hence the check to
> enforce that.

Hmm ok. I guess I can use two variables then because the only
case value will be negative is with locredit and this does not
need the do_div.

Thanks for the clarification.

Thanks and Best Regards,
Jose Miguel Abreu

>
> Gr{oetje,eeting}s,
>
>                         Geert
>

