From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 30 Apr 2014 00:59:46 +0000
Subject: Re: [PATCH/RFC] serial: sh-sci: Add device tree support for r8a7779
Message-Id: <48241008.smQVDtv0CD@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1398322484-3630-1-git-send-email-horms+renesas@verge.net.au>
 <1986104.5bpNkKVN8D@avalon> <20140429214846.GA27566@verge.net.au>
In-Reply-To: <20140429214846.GA27566@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Simon,

On Wednesday 30 April 2014 06:48:50 Simon Horman wrote:
> On Tue, Apr 29, 2014 at 03:44:46PM +0200, Laurent Pinchart wrote:
> > On Monday 28 April 2014 16:07:49 Simon Horman wrote:

[snip]

> > > BTW, are you planning to make the above mentioned driver update
> > > before or after re-posting enablement patches for Koelsch and/or Lager?
> > > I ask because I would like to make such patches the basis for
> > > a patch for Marzen.
> > 
> > I'll try to do so today, after my talk at the ELC :-)
> 
> I thought you might be a bit busy with ELC so I went
> ahead and made my Marzen patches. Hopefully they aren't
> too far away from what you have in mind for the Koelsch and Lager.

I was busy, but I've just sent the patches :-) Could you please test them ? If 
no problem is found I'd like the SCI patch to go in before this series, to 
avoid adding a dependency on sci_ick in the marzen DT.

-- 
Regards,

Laurent Pinchart

