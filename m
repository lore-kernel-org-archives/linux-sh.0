From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Date: Wed, 22 Jul 2009 04:47:59 +0000
Subject: Re: ATAPI drivers on the SH7724 chip
Message-Id: <20090722134759.f1a6fdf3.iwamatsu@nigauri.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20090715100214.1be10825.masao-takahashi@kanno.co.jp>
In-Reply-To: <20090715100214.1be10825.masao-takahashi@kanno.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,

On Tue, 21 Jul 2009 12:16:46 +0900
MASAO TAKAHASHI <masao-takahashi@kanno.co.jp> wrote:

> On Mon, 20 Jul 2009 04:36:41 +0900
> Paul Mundt <lethal@linux-sh.org> wrote:
> 
> > On Wed, Jul 15, 2009 at 10:02:14AM +0900, MASAO TAKAHASHI wrote:
> > > Do you have a plan to support a ATAPI driver on the SH7724 ?
> > > 
> > It is planned for the long term, but I am not sure when we will get to
> > it. Presently there is quite a lot of other SH7724 related work to do
> > that will take priority. The ATAPI interface also really wants
> > Iwamatsu-san's DMA engine work to be merged first.
> Mr Iwamatsu,
> Will you port SH7764 works to main line of sh-linux?

I dont have SH7764 board. If I have this, I can port.

If you need kernel which supports sh7764, you can get from
http://www.superh-linux.org/platforms/index.html#sh7764

Best regards,
 Nobuhiro



-- 
Nobuhiro Iwamatsu
	GPG ID: 3170EBE9
