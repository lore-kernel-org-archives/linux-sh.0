From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 27 Aug 2008 07:37:56 +0000
Subject: Re: new-machine.txt and include dir
Message-Id: <20080827073756.GC18717@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.0808270919590.27303@anakin>
In-Reply-To: <Pine.LNX.4.64.0808270919590.27303@anakin>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Aug 27, 2008 at 09:21:49AM +0200, Geert Uytterhoeven wrote:
> 	Hi Mundt-san,
> 
> I accidentally stumbled on Documentation/sh/new-machine.txt, which is no
> longer in sync with the actual location of the SuperH-specific include
> files.
> 
Yes, that's correct, it's not. It's also a few years out of sync with API
changes. Now that there's Documentation/DocBook/sh.tmpl, most of what's
on Documentation/sh will gradually be moved in to there, where we at
least have a reasonable chance of keeping things updated.

I'll add this to my todo list though, you seem to be the first one who
actually noticed, so we're going to have to be a bit less blatant with
documentation's utter disregard for reality :-)
