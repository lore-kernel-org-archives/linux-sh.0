From: Paul Mundt <lethal@linux-sh.org>
Date: Sun, 19 Jul 2009 22:06:47 +0000
Subject: Re: ATAPI drivers on the SH7724 chip
Message-Id: <20090719220647.GA14132@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20090715100214.1be10825.masao-takahashi@kanno.co.jp>
In-Reply-To: <20090715100214.1be10825.masao-takahashi@kanno.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, Jul 19, 2009 at 11:52:29PM +0200, Michael Trimarchi wrote:
> Paul Mundt wrote:
> >On Wed, Jul 15, 2009 at 10:02:14AM +0900, MASAO TAKAHASHI wrote:
> >>Do you have a plan to support a ATAPI driver on the SH7724 ?
> >>    
> >It is planned for the long term, but I am not sure when we will get to
> >it. Presently there is quite a lot of other SH7724 related work to do
> >that will take priority. The ATAPI interface also really wants
> >Iwamatsu-san's DMA engine work to be merged first.
> >  
> Is there a list a TODO list for each sh architecture?
> 
There is a general one on the wiki, but it is not itemized per CPU
subtype. We do keep some internal stats on IP blocks that do not
presently have matching drivers that could be extrapolated in to a status
matrix on the wiki, but it generally only tends to be the more exotic
blocks that are lacking drivers.
