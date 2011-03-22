From: Fabio Giovagnini <fabio.giovagnini@aurion-tech.com>
Date: Tue, 22 Mar 2011 13:50:27 +0000
Subject: Re: sh2a 7203 LCDC memory access
Message-Id: <201103221450.27805.fabio.giovagnini@aurion-tech.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201103220853.19384.fabio.giovagnini@aurion-tech.com>
In-Reply-To: <201103220853.19384.fabio.giovagnini@aurion-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Many thanks Magnus.
Very clear


On Tuesday 22 March 2011 13:21:48 Magnus Damm wrote:
> Hi Fabio,
> 
> On Tue, Mar 22, 2011 at 4:53 PM, Fabio Giovagnini
> 
> <fabio.giovagnini@aurion-tech.com> wrote:
> > Hi All,
> > I'd likt to keep you informed about my last discovering about LCDC of
> > sh2a 7203.
> > If I build the kernel with cache off, the image is clean and stable but
> > the performances are very very poor;
> > if I build with cache write back the performaces are very good but the
> > image is stable but sometimes dirty; fi I build with cache write through
> > the performances seems to be a little bit less than write back but the
> > image is stiil clean and stable.
> > Does this make sense?
> 
> Yes.
> 
> > How can I explain this behaviour?
> 
> The LCDC is an output device looking from the CPU point of view.
> 
> The write-though cache setting is OK for output even though you are
> not flushing the cache. It behaves the same as cache off for writing
> because the data is always written _through_ the cache directly to the
> memory that is read by the LCDC.
> 
> If you use copy-back (write-back) but picture is not OK then this
> means the data is left in the cache and has not been written out to
> memory. The copy-back cache is only writing to memory when running our
> of cache space or your are flushing the data to memory by software
> control.
> 
> You need to make sure your frame buffer is flushed after writing. Or
> use an uncached memory area for the frame buffer - that's even easier.
> 
> Good luck!
> 
> / magnus

-- 
Ing. Fabio Giovagnini

Aurion s.r.l.
P.I e C.F.
00885711200
skype: aurion.giovagnini
Tel. +39.051.594.78.24
Fax. +39.051.082.14.49
Cell. +39.335.83.50.919
www.aurion-tech.com
