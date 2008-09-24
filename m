From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 24 Sep 2008 15:49:01 +0000
Subject: Re: SH7722 serial scif
Message-Id: <20080924154901.GA8234@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <878566.91579.qm@web26201.mail.ukl.yahoo.com>
In-Reply-To: <878566.91579.qm@web26201.mail.ukl.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Sep 24, 2008 at 02:52:05PM +0000, Michael Trimarchi wrote:
> I find a problem releated to the scif serial device. Using scif2 on the
> MigoR, the kernel block on the second open of the device when it try to
> register irq line. So in the shutdown sequence I add:
> 
>  sci_out(port, SCSCR, 0x00);
> 
> and in the startup squence:
> 
>  sci_out(port, SCSCR, SCSCR_INIT(port));
> 
> The version is 2.6.24.2 but I think is present in the latest release too.
> 
> My idea is to post a patch to register and enable and disable for the
> scif port on the SH7722. Can be a problem for other micro?
> 
I'm not entirely sure I follow what the problem is, so yes, a patch would
help. It sounds like you are running in to a problems trying to do multiple
opens on the same port where request_irq() returns -EBUSY or some such
thing? I don't immediately see how that would be happening, so perhaps
I'm misunderstanding your problem.
