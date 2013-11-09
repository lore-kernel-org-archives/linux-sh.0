From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Sat, 09 Nov 2013 12:39:51 +0000
Subject: Re: [PATCH/RFC] ARM: Rename ARCH_SHMOBILE to ARCH_SHMOBILE_LEGACY
Message-Id: <13183576.7iF6znRvQU@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1383782061-7111-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1383782061-7111-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Stephen,

On Friday 08 November 2013 14:57:29 stephen.lawrence@renesas.com wrote:
> linux-sh-owner@vger.kernel.org wrote on 08/11/2013 06:08:05:
> > On Thu, Nov 07, 2013 at 03:04:57PM +0900, Magnus Damm wrote:
> > > On Thu, Nov 7, 2013 at 8:54 AM, Laurent Pinchart wrote:
> > > > SH-Mobile platforms are transitioning from non-multiplatform to
> > > > multiplatform kernel. A new ARCH_SHMOBILE_MULTI configuration symbol
> > > > has been created to group all multiplatform-enabled SH-Mobile SoCs.
> > > > The existing ARCH_SHMOBILE configuration symbol groups SoCs that
> > > > haven't been converted yet.
> 
> I'm sure there are reasons for keeping it but looking forward I can't help
> but wonder if this wouldn't be a good time to lose the SHMOBILE tag for
> new platforms? It doesn't seem to be a great match to our business or the
> architectures.
> 
> I know from conversations I've had in the last year or so that external
> engineers working on R-Car sometimes do not find your good work upstream
> as the combination of sh-mobile and using the product number proved an
> effective method of concealment. Although of course they could find it by
> searching the right files.

It's not a bad idea, but I'm not sure how we could proceed. SH-Mobile, R-
Mobile and R-Car chipsets are all supported by a single code base, for which 
we need a name. Splitting the code base wouldn't make much sense from a 
technical point of view.

-- 
Regards,

Laurent Pinchart

