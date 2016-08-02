From: Rich Felker <dalias@libc.org>
Date: Tue, 02 Aug 2016 22:00:35 +0000
Subject: Re: [PATCH v4 1/2] of: add J-Core SPI master bindings
Message-Id: <20160802220035.GB15995@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1469686300.git.dalias@libc.org>
 <9813bf559ad89ca6fecc438d9176d634bbc122a0.1469686300.git.dalias@libc.org>
 <20160729205838.GA28548@rob-hp-laptop>
In-Reply-To: <20160729205838.GA28548@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

On Fri, Jul 29, 2016 at 03:58:38PM -0500, Rob Herring wrote:
> On Tue, May 17, 2016 at 11:19:25PM +0000, Rich Felker wrote:
> > Signed-off-by: Rich Felker <dalias@libc.org>
> > ---
> >  .../devicetree/bindings/spi/jcore,spi.txt          | 30 ++++++++++++++++++++++
> >  1 file changed, 30 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/spi/jcore,spi.txt
> 
> Acked-by: Rob Herring <robh@kernel.org>

Thanks. Since I switched to to using the clk framework rather than a
clock-frequency property (at Mark Brown's suggestion/request), I'll be
submitting one more version for your review.

After that, who should be responsible for upstreaming this and the
other binding patches? You, me, or the subsystem maintainers that the
drivers are going through?

Rich
