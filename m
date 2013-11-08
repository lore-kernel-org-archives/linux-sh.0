From: stephen.lawrence@renesas.com
Date: Fri, 08 Nov 2013 14:57:29 +0000
Subject: Re: [PATCH/RFC] ARM: Rename ARCH_SHMOBILE to ARCH_SHMOBILE_LEGACY
Message-Id: <OF17E16328.5264A205-ON80257C1D.00509463-80257C1D.00522B18@eu.necel.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1383782061-7111-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1383782061-7111-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

linux-sh-owner@vger.kernel.org wrote on 08/11/2013 06:08:05:

Hi Guys,

> From: Simon Horman <horms@verge.net.au>
> To: Magnus Damm <magnus.damm@gmail.com>, 
> Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
SH-Linux <linux-
> sh@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" 
<linux-arm-kernel@lists.infradead.org>
> Date: 08/11/2013 06:07
> Subject: Re: [PATCH/RFC] ARM: Rename ARCH_SHMOBILE to 
ARCH_SHMOBILE_LEGACY
> Sent by: linux-sh-owner@vger.kernel.org
> 
> On Thu, Nov 07, 2013 at 03:04:57PM +0900, Magnus Damm wrote:
> > Hi Laurent,
> > 
> > On Thu, Nov 7, 2013 at 8:54 AM, Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com> wrote:
> > > SH-Mobile platforms are transitioning from non-multiplatform to
> > > multiplatform kernel. A new ARCH_SHMOBILE_MULTI configuration symbol 
has
> > > been created to group all multiplatform-enabled SH-Mobile SoCs. The
> > > existing ARCH_SHMOBILE configuration symbol groups SoCs that haven't
> > > been converted yet.
> > >

I'm sure there are reasons for keeping it but looking forward I can't help 
but wonder if this wouldn't be a good time to lose the SHMOBILE tag for 
new platforms? It doesn't seem to be a great match to our business or the 
architectures.

I know from conversations I've had in the last year or so that external 
engineers working on R-Car sometimes do not find your good work upstream 
as the combination of sh-mobile and using the product number proved an 
effective method of concealment. Although of course they could find it by 
searching the right files.

Have a good weekend,

Steve
