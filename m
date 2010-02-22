From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 22 Feb 2010 02:35:31 +0000
Subject: Re: [PATCH] sh: sh7724: Add workaround for FSI sound
Message-Id: <aec7e5c31002211835t5abf4f9bjc33b9e4c286abc8c@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <upr41pseb.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <upr41pseb.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Feb 22, 2010 at 10:02 AM, Kuninori Morimoto
<morimoto.kuninori@renesas.com> wrote:
>> When FSI and Network (= NFS file system) had been used
>> at the same time, the I/O of FSI was unstable.
>> This patch modify the SPU2 clock which is used for FSI
>> as nearly equal system clock for stable continuous operation.
>> Special thanks to Jeremy.
>
> I sent this patch, but I should used set_rate function.
> And I wonder should I add it in FSI driver ?

I guess you want to set "spu_clk" to 12.288MHz?

Please use clk_set_rate() and clk_round_rate() like this patch:

http://marc.info/?l=linux-sh&m6657205426784&w=2

Thanks,

/ magnus
