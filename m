From: Prabhakar Lad <prabhakar.csengg@gmail.com>
Date: Mon, 17 Jun 2013 15:39:16 +0000
Subject: Re: [PATCH v11 14/21] V4L2: add temporary clock helpers
Message-Id: <CA+V-a8u67RqLeQWs4iNHs7S9UXTBOFFw0wu+9hwndUBiwbHaMw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1371236911-15131-1-git-send-email-g.liakhovetski@gmx.de> <1371236911-15131-15-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1371236911-15131-15-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-media@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Hans Verkuil <hverkuil@xs4all.nl>, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Sakari Ailus <sakari.ailus@iki.fi>, Prabhakar Lad <prabhakar.lad@ti.com>, Sascha Hauer <s.hauer@pengutronix.de>

Hi Guennadi,

Thanks for the patch.

On Sat, Jun 15, 2013 at 12:38 AM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> Typical video devices like camera sensors require an external clock source.
> Many such devices cannot even access their hardware registers without a
> running clock. These clock sources should be controlled by their consumers.
> This should be performed, using the generic clock framework. Unfortunately
> so far only very few systems have been ported to that framework. This patch
> adds a set of temporary helpers, mimicking the generic clock API, to V4L2.
> Platforms, adopting the clock API, should switch to using it. Eventually
> this temporary API should be removed.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Acked-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>

Regards,
--Prabhakar Lad
