From: "Magnus Damm" <magnus.damm@gmail.com>
Date: Fri, 19 Dec 2008 04:38:10 +0000
Subject: Re: A patch got applied to v4l bypassing v4l lists
Message-Id: <aec7e5c30812182038v5d89c2bnfc2a71ebd61783b@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.0812181613050.5510@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.0812181613050.5510@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Magnus Damm <damm@igel.co.jp>, video4linux-list@redhat.com, Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org

Hi Guennadi,

On Fri, Dec 19, 2008 at 12:23 AM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> just stumbled upon a patch
>
> sh: sh_mobile ceu clock framework support
>
> that has been pulled through linux-sh ML and the sh tree without even
> being cc-ed to the v4l list, which wasn't a very good idea IMHO. Now this
> patch has to be manually "back-ported" to v4l hg repos using the
> "kernel-sync:" tag and only in part, because arch/sh directory is not in
> hg at all. Can we please avoid this in the future?

That specific patch set improved clock framework support and changed
quite a few SuperH drivers. I should have CC-ed you. Sorry about that,
will do next time.

/ magnus
