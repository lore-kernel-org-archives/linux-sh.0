From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 26 Jan 2009 02:20:56 +0000
Subject: Re: [bug report] dead lock (?) occur on ap325 board
Message-Id: <20090126022055.GE17836@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <uprie4cmj.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uprie4cmj.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Jan 23, 2009 at 06:04:20PM +0900, morimoto.kuninori@renesas.com wrote:
> I found dead lock (? freeze?) bug again on
> ------------------------------------------------
> commit 77ba93a7ac5fb0d9338bffbf97c787b8efe00806
> Author: Paul Mundt <lethal@linux-sh.org>
> Date:   Mon Dec 8 11:25:50 2008 +0900
> 
>     sh: Fix up the SH-4A mutex fastpath semantics.
> ------------------------------------------------
> 
> I get dead lock even if following patch is added
> (this bug will be fixed on 06be3724548a443a99d703ff79f43d6f1e2975f0)
> ----------------
> Author: Paul Mundt <lethal@linux-sh.org>
> Date:   Mon Dec 8 17:01:40 2008 +0900
> 
>     sh: Fix an off-by-1 check in __mutex_fastpath_unlock().
> ----------------
> 
> c6f17cb2272121475c87592560534b157b17544e is OK for me.
> (but YOSHII-san's patch (3b041227f7ef7c7e97f205c68c6069c0c62e5204)
>  is still needed.)
> 
I haven't been able to reproduce this yet, but it would be helpful to
know precisely where your lock up occurs. If you aren't using JTAG, you
can try sending an NMI, or send a register and/or stacktrace request via
magic sysrq.
