From: ivy kim <ibkim63@gmail.com>
Date: Wed, 28 Oct 2009 08:07:23 +0000
Subject: Re: SH ATAPI IDE Driver
Message-Id: <32390a840910280107s7fcc7955u3bb8990e71efc061@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <32390a840910052042t64346e53w1bfb3473c7b2284b@mail.gmail.com>
In-Reply-To: <32390a840910052042t64346e53w1bfb3473c7b2284b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Dear,

> For starters, no new drivers should be written aimed at drivers/ide,
> libata is what you should be working with instead, aiming your driver at
> drivers/ata (you can see many other pata drivers there for examples on
> getting started, including ones that deal with ATAPI).
>
Although it's late, thank you for the answer. I managed to make IDE working.
But this is just PIO mode, and now I'm checking DMA mode but I read
the following article before, so I want to check if I should use
latest source code if the below mentioned DMA engine work is done.
For now, I'm using 'sh-2.6-2009-06-08-ms7724se-2.6.30-rc6'

Later on, I'll post at linux-ide mailing list...

Thanks.
BR.

-----------------
Hi,

Paul Mundt wrote:

>On Wed, Jul 15, 2009 at 10:02:14AM +0900, MASAO TAKAHASHI wrote:
>>Do you have a plan to support a ATAPI driver on the SH7724 ?
>
>It is planned for the long term, but I am not sure when we will get to
>it. Presently there is quite a lot of other SH7724 related work to do
>that will take priority. The ATAPI interface also really wants
>Iwamatsu-san's DMA engine work to be merged first.

>Is there a list a TODO list for each sh architecture?

Michael
-------------
