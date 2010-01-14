From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 14 Jan 2010 23:30:21 +0000
Subject: Re: [PATCH] sh-sci: using correct fifo size for SCIF and SCIFA
Message-Id: <20100114233021.GB25018@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <95F51F4B902CAC40AF459205F6322F0164298E5C37@BMK019S01.emtrion.local>
In-Reply-To: <95F51F4B902CAC40AF459205F6322F0164298E5C37@BMK019S01.emtrion.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Jan 13, 2010 at 02:25:34PM +0100, Pietrek, Markus wrote:
> the sh-sci driver used the wrong fifosize for PORT_SCIFA and PORT_SCIF.
> If an incorrect size is used, the serial core will enforce a shutdown
> of a device too early, especially on baudrates < 9600.
> 
Good catch, I'll roll this in to the 2.6.33 queue, thanks.
