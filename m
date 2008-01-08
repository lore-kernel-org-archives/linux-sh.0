From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 08 Jan 2008 08:08:13 +0000
Subject: Re: About invalidate cache of SH4
Message-Id: <20080108080813.GA24344@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <47832D9E.1010201@renesas.com>
In-Reply-To: <47832D9E.1010201@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Jan 08, 2008 at 05:00:30PM +0900, Yoshihiro Shimoda wrote:
> For example, struct scsi_cmnd has sense_buffer[]. sense_buffer
> is not cache alignment. When there is invalidated sense_buffer,
> struct request *request of struct scsi_cmnd may be invalidated.
> Connection of the USB memory sometimes fails and cannnot mount
> USB-CDROM(oops occured) for this processing.
> 
This is a known issue, and is currently being debated on l-k:

http://lkml.org/lkml/2007/12/20/660

Once there's a resolution, the driver will either be fixed, or we set up
the minimum alignment to a cacheline boundary.
