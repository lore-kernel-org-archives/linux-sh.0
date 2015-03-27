From: Simon Horman <horms@verge.net.au>
Date: Fri, 27 Mar 2015 22:04:55 +0000
Subject: Re: [PATCH/RFC] i2c: rcar: Support ACK by HW auto restart after NACK
Message-Id: <20150327220451.GA25459@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1424011480-3551-1-git-send-email-ykaneko0929@gmail.com>
 <2775fbb6b2e2b333ef2457133f419d4d@the-dreams.de>
 <20150304040635.GA12776@verge.net.au>
 <20150306221809.GB6572@katana>
 <20150327131104.GC19151@katana>
In-Reply-To: <20150327131104.GC19151@katana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Yoshihiro Kaneko <ykaneko0929-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi Wolfram,

On Fri, Mar 27, 2015 at 02:11:04PM +0100, Wolfram Sang wrote:
> On Fri, Mar 06, 2015 at 11:18:09PM +0100, Wolfram Sang wrote:
> > 
> > > > >Even if R-Car I2C received NACK, after that it might receive ACK
> > > > >by HW auto restart. In case of that, driver would continue process.
> > > > >If R-Car I2C didn't receive ACK, the driver would detect timeout
> > > > >and would report NACK as -ENXIO.
> > > > >
> > > > >Signed-off-by: Ryo Kataoka <ryo.kataoka.wt@renesas.com>
> > > > >Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
> > > > 
> > > > Excuse me, but what exactly is HW auto restart in this case? Is it a feature
> > > > of the I2C slave?
> > > 
> > > I asked Kataoka-san about this and his response was as follows:
> > > 
> > >     It is a feature of the i2c-rcar(H/W) master.
> > > 
> > >     If system(CPU) is busy, NACK procedure may have interrupt latency.
> > >     Since the clear of ICMCR.ESG bit is delayed, i2c-rcar(H/W) may auto-restart
> > >     after NACK. Please refer to ESG bit of H/W UM section 55.3.5.
> > > 
> > >     For example, this is I2C write transmitting.
> > >     1.Start / 2.SlaveAddr,ACK / 3.RegAddr,ACK / 4.RegData,ACK / 5.Stop
> > > 
> > >     If No.2 has NACK and interruption has delay, this transmitting is as follows.
> > >     1.Start / 2.SlaveAddr,NACK/ 1x.auto-restart / 2x.SlaveAddr,ACK
> > >                                     / 3.RegAddr,ACK / 4.RegData,ACK / 5.Stop
> > > 
> > >     NACK of No.2 is invalidated by ACK of No.2x. It means recover.
> > 
> > Does this make some I2C device work which did not work before?
> > 
> > Most I2C devices always ack their address, so NACK very often means
> > "nothing is there". I think it makes sense that the rcar driver returns
> > ENXIO in this case which is documented to be used for NACK after address
> > phase. Then, the i2c client driver should know if this means "not there"
> > or "currently busy". And it should know when is a good time for another
> > try. As I read the patch, the driver would use the auto-restart feature
> > until the timeout is reached. That would make bus scanning pretty slow,
> > too.
> 
> Hi,
> 
> any news on this one?

Sorry for not responding earlier. I have the following information from
Kataoka-san.

* There are now several patches in the BSP that address this issue;
  this patch and two follow up fix patches. Its probably best if these
  patches were all squashed into a single patch for your consideration.

  For reference I am referring to the following patches in the BSP:

  i2c: rcar: Support ACK by HW auto restart after NACK
  i2c: rcar: Fix status clear after NACK
  i2c: rcar: Fix flag clear for recovering by HW auto restart

* In answer to your questions above:

  "When NACK interruption occurs, the i2c rcar driver sets ICMCR register
   from (MDBS|MIE|ESG) to (MDBS|MIE|FSB) in rcar_i2c_bus_phase().  It means
   clearing of ESG bit. If this procedure is late, H/W auto-restarts.  After
   that, if NACK occurs again, H/W doesn't auto-restart because ESG bit was
   already cleared.

   S/W doesn't know whether H/W did auto-restart or did not auto-restart.
   So, S/W needs to wait. The return of ENXIO is pretty slow.

   It takes long time but I think it's ok because NACK is unjust case."
