From: Phil.Edworthy@renesas.com
Date: Wed, 12 Mar 2014 09:57:53 +0000
Subject: Re: NFS root on Koelsch reference
Message-Id: <OF00616D03.A869ED88-ON80257C99.00362DA0-80257C99.0036BD02@eu.necel.com>
List-Id: <linux-sh.vger.kernel.org>
References: <CAMuHMdUND0D8rj4K3ZPqx1XqS7czK3PeHfBqTu2WRWQw3Ecj1A@mail.gmail.com>
In-Reply-To: <CAMuHMdUND0D8rj4K3ZPqx1XqS7czK3PeHfBqTu2WRWQw3Ecj1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,

On 11/03/2014 10:48, Geert wrote:
> Subject: Re: NFS root on Koelsch reference
> Sent by: linux-sh-owner@vger.kernel.org
> 
> Hi Sergei,
> 
> On Fri, Mar 7, 2014 at 7:57 PM, Sergei Shtylyov
> <sergei.shtylyov@cogentembedded.com> wrote:
> >> We also need a fix for the Micrel PHY to set the LED mode on the
> >> Lager board. I've sent that but it seems to have stalled.
> >
> >    While we're not having it, try changing 
"renesas,ether-link-active-low"
> > prop to "renesas,no-ether-link" in the Koelsch device tree file.
> 
> Thanks, that decreases the part between nfsroot mount and system ready
> from 54 s to 15 s, hence
> 
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> 
> Gr{oetje,eeting}s,
> 
>                         Geert

I'm trying to do some DT work for the R-Car PCIe driver, but can't get NFS 
root working on Koelsch. It's not even loading the driver... I'm working 
off Simon's devel branch, is there any other patches required to get this 
working?

Thanks
Phil
