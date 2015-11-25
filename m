From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 25 Nov 2015 06:34:26 +0000
Subject: Re: [PATCH] drm: adv7511: really enable interrupts for EDID detection
Message-Id: <CANqRtoTAPU3zni__J2MQR+KK=SUUGYLgHz5j9s04CjEq55s3hg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1448376627-12255-1-git-send-email-wsa@the-dreams.de>
	<20151124210501.GA1584@katana>
In-Reply-To: <20151124210501.GA1584@katana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>
Cc: dri-devel@lists.freedesktop.org, SH-Linux <linux-sh@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>

Hi Wolfram,

On Wed, Nov 25, 2015 at 6:05 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
>
>> Note that I could not yet read EDID with Magnus' Koelsch.
>
> This has been tackled as well now. The clock for the GPIO controller was
> off, so no interrupt was passed through.

Thanks a lot for your efforts! When you have time, can you please show
me the patch that fixes that GPIO interrupt problem? I'm asking
because I may have ran into a similar issue on Gose or Alt.

Cheers,

/ magnus
