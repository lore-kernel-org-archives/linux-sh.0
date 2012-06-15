From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 15 Jun 2012 07:09:15 +0000
Subject: Re: [PATCH] mmc: tmio: Don't access hardware registers after stopping clocks
Message-Id: <Pine.LNX.4.64.1206150907110.11729@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <1339505838-8831-1-git-send-email-laurent.pinchart@ideasonboard.com>
 <CANqRtoQdzq5VHqBo1WQUYimVAYsGM6+XmE5r1Aoadm_HpY=eMA@mail.gmail.com>
 <1538938.WjgJgiBpYR@avalon> <CANqRtoS3JqNHFXcOutssQxpD6DNnyV1QawT2hf251z5d05LJWw@mail.gmail.com>
In-Reply-To: <CANqRtoS3JqNHFXcOutssQxpD6DNnyV1QawT2hf251z5d05LJWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org

On Fri, 15 Jun 2012, Magnus Damm wrote:

[snip]

> Guennadi, does this trigger on sh7372 as well? If not, why is that?

No. That message is produced by the sh_mobile_sdhi_wait_idle() function, 
which is only used, if the TMIO_MMC_HAS_IDLE_WAIT flag is set, which is 
not set on mackerel (or ap4evb).

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
