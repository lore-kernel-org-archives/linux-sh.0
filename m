From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 17 Nov 2015 07:38:10 +0000
Subject: Re: [PATCH v2 05/10] i2c: rcar: refactor setup of a msg
Message-Id: <2998465.01LOgISn2O@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1447338715-9955-1-git-send-email-wsa@the-dreams.de> <2420286.JI0i0lloO0@avalon> <20151117070053.GA952@tetsubishi>
In-Reply-To: <20151117070053.GA952@tetsubishi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Geert Uytterhoeven <geert@linux-m68k.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>

Hi Wolfram,

On Tuesday 17 November 2015 08:00:53 Wolfram Sang wrote:
> Hi Laurent,
> 
> > Sorry for bringing bad news, but as with v1, this patch breaks ADV7511
> > detection on my Koelsch board. Reverting it on top of the series fixes the
> > problem.
> 
> In v1, patch 5/9 was breaking. I hope in v2, it is 6/10 and not 5/10 as
> you replied to (patch 1/10 is the new one)? This bug is strange enough,
> but 5/10 breaking would be extremly crazy.

My bad, it's indeed "[PATCH v2 06/10] i2c: rcar: init new messages in irq" 
that I have reverted on top of the series.

> > You'll find the dmesg and trace logs with your debugging patch applied
> > attached to this e-mail in two versions, one with the whole series applied
> > (- bad) and one with this patch additionally reverted on top of the
> > series (- good).
> 
> Thanks for doing this. I'll think about it some more, but it may be that
> I am running out of ideas without being able to connect a scope. Would
> it be possible to exchange our Koelsch and Lager boards for a while? Or
> is your multimedia work Koelsch dependant?

I'm currently doing multimedia development on Koelsch. I'll check whether I 
can continue that on Lager. In the meantime I could also capture I2C traces 
using a scope and send them to you.

-- 
Regards,

Laurent Pinchart

