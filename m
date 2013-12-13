From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 13 Dec 2013 17:00:03 +0000
Subject: Re: [PATCH] PCI: rcar: fix return value check in rcar_pci_probe()
Message-Id: <CAErSpo72MYGvg9p2-2YCdvhzK4Mvp6j81P77sQPno34bKZPtuw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <CAPgLHd-XTnQXdK7H2uLbGW1ftxNB_nHwzcNCoiCjpXsB5X3HnA@mail.gmail.com>
 <20131207225012.GC7901@google.com> <001001cef480$73896b20$5a9c4160$%han@samsung.com>
 <20131211023006.GN19992@verge.net.au> <52AAF85E.80206@cogentembedded.com>
In-Reply-To: <52AAF85E.80206@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Valentine <valentine.barshak@cogentembedded.com>
Cc: Simon Horman <horms@verge.net.au>, Jingoo Han <jg1.han@samsung.com>, Wei Yongjun <weiyj.lk@gmail.com>, Wei Yongjun <yongjun_wei@trendmicro.com.cn>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-sh@vger.kernel.org

On Fri, Dec 13, 2013 at 5:06 AM, Valentine
<valentine.barshak@cogentembedded.com> wrote:
> On 12/11/2013 06:30 AM, Simon Horman wrote:
>>
>> On Mon, Dec 09, 2013 at 10:46:17AM +0900, Jingoo Han wrote:
>>>
>>> On Sunday, December 08, 2013 7:50 AM, Bjorn Helgaas wrote:

>>>> For drivers/pci/host/*, I normally look for an ack from the responsible
>>>> person,  but this patch is trivial enough that I'm fine taking it
>>>> without
>>>> that.  But for more significant changes, I don't have any notes about
>>>> who
>>>> should own pci-rcar-gen2.c.  Valentine could be a candidate since he
>>>> added
>>>> it in the first place?  Or Jingoo?
>
>
> Sorry, I didn't ack since I thought it was not really needed for a trivial
> change like this one that had already been reviewed by Jingoo.

To be honest, I'm just trying to save myself some work by looking for
an ack.  I want to have an indication that at least one person besides
the author approves, and if nobody else looks at it, I have to do it
myself :)

>> I will let Valentine volunteer himself if he wants to.
>
>
> I'll try to track the e-mails related to this driver as well.
>
> Not sure if I want myself in the MAINTAINERS though, since it would probably
> mean that "try to" should be changed to "have to" in my statement above.

Fair enough, thanks!  Let me know if anything changes here.

Bjorn
