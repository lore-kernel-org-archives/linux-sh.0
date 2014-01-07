From: Simon Horman <horms@verge.net.au>
Date: Tue, 07 Jan 2014 01:29:38 +0000
Subject: Re: [PATCH 1/2] ARM: shmobile: koelsch: (1+1)GiB memory in DT
Message-Id: <20140107012938.GE2196@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1387704444-750-2-git-send-email-takasi-y@ops.dti.ne.jp>
In-Reply-To: <1387704444-750-2-git-send-email-takasi-y@ops.dti.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Dec 23, 2013 at 09:58:24AM +0900, Simon Horman wrote:
> On Sun, Dec 22, 2013 at 06:27:23PM +0900, takasi-y@ops.dti.ne.jp wrote:
> > From: Takashi Yoshii <takasi-y@ops.dti.ne.jp>
> > 
> > Fix dts to have memory 1GiB @ 0_4000_0000 + 1GiB @ 2_0000_0000
> > according to Koelsch's hardware manual.
> > 
> > Signed-off-by: Takashi Yoshii <takasi-y@ops.dti.ne.jp>
> 
> Thanks Yoshii-san, this seems reasonable to me.
> Could I as that in future when posting patches you use your first and
> last name in the from addresss, rather than just your email address.
> 
> e.g.
> 
> Takashi Yoshii <takasi-y@ops.dti.ne.jp>
> 
> instead of
> 
> takasi-y@ops.dti.ne.jp
> 
> That would make my life slightly easier.
> 
> 
> Magnus, can I get an Ack or otherwise from you?

I have queued up this change.

> 
> > ---
> >  arch/arm/boot/dts/r8a7791-koelsch.dts |    7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
> > index fd556c3..63eee03 100644
> > --- a/arch/arm/boot/dts/r8a7791-koelsch.dts
> > +++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
> > @@ -23,7 +23,12 @@
> >  
> >  	memory@40000000 {
> >  		device_type = "memory";
> > -		reg = <0 0x40000000 0 0x80000000>;
> > +		reg = <0 0x40000000 0 0x40000000>;
> > +	};
> > +
> > +	memory@200000000 {
> > +		device_type = "memory";
> > +		reg = <2 0x00000000 0 0x40000000>;
> >  	};
> >  
> >  	lbsc {
> > -- 
> > 1.7.9.5
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
