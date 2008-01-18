From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 18 Jan 2008 01:01:31 +0000
Subject: Re: [PATA_PLATFORM] : "Driver 'sd' needs updating - please use bus_type methods
Message-Id: <20080118010131.GB14945@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Jan 18, 2008 at 12:31:18AM -0800, Kristoffer Ericson wrote:
> Driver 'sd' needs updating - please use bus_type methods
> 
The 'sd' thing is explained in this thread on l-k:

	http://marc.info/?t9995530000002&r=1&w=2

Like most of the driver model, it's annoying, but harmless.
