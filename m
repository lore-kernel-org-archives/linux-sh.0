From: "uClinux.org" <Jeff@uClinux.org>
Date: Mon, 11 Jan 2016 02:22:59 +0000
Subject: Re: [PATCH 2/2] MAINTAINERS: remove linux-sh list from non-arch/sh sections
Message-Id: <785CFEED-43D7-4C08-9659-6E394ED1B89E@uClinux.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20160108043907.GA7005@brightrain.aerifal.cx> <20160108065642.GA1215@verge.net.au> <568FF369.9080006@landley.net> <7119737.DzNTr3WlaV@avalon> <56903D52.3000908@landley.net> <CAMuHMdWe9=_ooKRA86+PwP62fRKEbMRgp+12ZfMw4sHaib=0mQ@mail.gmail.com> <56930D30.4040801@landley.net>
In-Reply-To: <56930D30.4040801@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Landley <rob@landley.net>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Simon Horman <horms@verge.net.au>, Rich Felker <dalias@libc.org>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>

On Jan 11, 2016, at 11:02, Rob Landley <rob@landley.net> wrote:

>>>> meaning has shifted more to the "Linux Renesas mailing list".
>> 
>> What I mean is that this is still a public mailing list for the Linux kernel community, to discuss and develop for Renesas SoCs, which are evolutions from the old SuperH SoCs.
> 
> There is a lot of unrelated traffic on here which is just noise for the original purpose of maintaining arch/sh, yes.

And -this- is the point.  SH is an ISA, which is no longer controller by Renensas, nee Hitachi Semiconductor.  We now have (and employ as their day job) some of the original architects of that ISA in the J-Core project.  Renesas has abandoned the ISA, now that the patents have expired.

We aim to build community support, in the Linux community, for this ISA.  That means 'public mailing list... old SuperH SoCs' is not only the wrong way to look at it, it's actually counter productive to building that support.  Who wants old SoCs?