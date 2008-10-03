From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 03 Oct 2008 10:35:04 +0000
Subject: Re: Porting UART driver for linux-2.6.22.11 on T-engine 7727
Message-Id: <20081003103503.GA16837@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <loom.20081003T085552-971@post.gmane.org>
In-Reply-To: <loom.20081003T085552-971@post.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Oct 03, 2008 at 09:29:55AM +0000, Cuong Dang Phu wrote:
> Hi,
> 
> I'm starting to port UART driver on SH7727 T-Engine Board, what should I do?
>      + How do I configure kernel?
>      + What should files change?
> These are some information which I get:
>      This is chip (EXAR ST16C2550) is controller in the UART control block: 
> http://www.exar.com/Common/Content/ProductDetails.aspx?ID=ST16C2550
>      I had datasheet.
> 
This device is already generically supported through the 8250 driver, so
you should only have to set up a platform device for it. Grep for
'serial8250' in arch/ and you can find plenty of examples for how to set
that up for your board.
