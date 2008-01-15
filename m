From: "Adrian McMenamin" <lkmladrian@gmail.com>
Date: Tue, 15 Jan 2008 20:41:39 +0000
Subject: Re: [PATCH] SH/Dreamcast - add support for GD-Rom CDROM drive on SEGA Dreamcast
Message-Id: <8b67d60801151241p31ade7ald4421dc0f34d5212@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1200007549.6349.16.camel@localhost.localdomain>
	 <1200088609.6213.3.camel@localhost.localdomain>
	 <20080112053630.0ccb290e.akpm@linux-foundation.org>
	 <1200351607.6196.4.camel@localhost.localdomain>
	 <1200352635.6196.8.camel@localhost.localdomain>
	 <20080115002958.GA27597@linux-sh.org>
In-Reply-To: <20080115002958.GA27597@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>, Adrian McMenamin <adrian@newgolddream.dyndns.info>, Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <jens.axboe@oracle.com>, linux-sh <linux-sh@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On 15/01/2008, Paul Mundt <lethal@linux-sh.org> wrote:
> On Mon, Jan 14, 2008 at 11:17:15PM +0000, Adrian McMenamin wrote:

>
> > +static bool gdrom_data_request(void)
> > +{
> > +     return (ctrl_inb(GDROM_ALTSTATUS_REG) & 0x88) = 8;
> > +}
> > +
> Andrew first pointed this out, and this is still broken.
>

Eh, no, he didn't. What is wrong with it?

He compalined about excessively long busy waiting and then not
checking if the busy wait failed. Both those have been fixed.
