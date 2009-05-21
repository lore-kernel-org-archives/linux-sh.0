From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 21 May 2009 09:30:52 +0000
Subject: Re: [PATCH 0/3] Convert SuperH camera-enabled platforms to soc-camera
Message-Id: <aec7e5c30905210230g6cdac25w68189b1d2c16086e@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.0905121649420.5087@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.0905121649420.5087@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Linux Media Mailing List <linux-media@vger.kernel.org>, Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org

On Wed, May 13, 2009 at 12:13 AM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> Now that soc-camera compatibility patch is in the mainline, we can convert
> all platforms to the new scheme. This patch series converts SuperH boards.
> Unfortunately, the first patch has to also (slightly) modify two camera
> drivers, but that looks like a minor inconvenience to me, at least when
> compared to my original convert-all-at-once mega-patch.

I've tried capturing with these patches applied to next-20090520.
Works fine on Migo-R. The boot output looks ok on ap325 as well
(ov772x detected), have not tried capturing with that board though.
Thanks for your help!

Acked-by: Magnus Damm <damm@igel.co.jp>
