From: Bastian Hecht <hechtb@gmail.com>
Date: Wed, 06 Mar 2013 12:49:03 +0000
Subject: Re: Power management test code samples
Message-Id: <CABYn4syX9E_BKx=T7NkignYvf1Uy85MEwC7P_raPpqo2qmwaQQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <CABYn4sypQ2VzigxmRwiqWnDim1zPiAcb_NrYbBxnRt0FMCq0vA@mail.gmail.com>
In-Reply-To: <CABYn4sypQ2VzigxmRwiqWnDim1zPiAcb_NrYbBxnRt0FMCq0vA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello Morimoto-san,

2013/3/6 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>:
>
> Hi Bastian
>
>> hereby I ask officially if there is some test code available regarding
>> the power management of the SoCs r8a7740 and sh73a0.
>>
>> I'm interested in the exact handling of the different caches (L1, L2,
>> TLB) and shutdown/wakeup procedures. Sample code would help a lot so I
>> can compare what the v7_cpu_suspend code already does and what is
>> needed in the SoC-specific code.
>
> Can this help you ?
> It is for r8a7740, and still "sample-code"

Oh yes very useful information, thank you! There are some constant
definitions like
PL310_REG1_CTRL
PL310_REG1_AUXCTRL
...

that seem to be included "hardware.inc". Is it possible to get these values too?

Thanks,

 Bastian


> Best regards
> ---
> Kuninori Morimoto
>
