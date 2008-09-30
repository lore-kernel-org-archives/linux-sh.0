From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 30 Sep 2008 01:56:37 +0000
Subject: Re: [RFC] sh7751(r): Adding support for PCI-DMA
Message-Id: <20080930015637.GA4962@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <7b5883fc0809260450w642dde94k1c25166d8305f007@mail.gmail.com>
In-Reply-To: <7b5883fc0809260450w642dde94k1c25166d8305f007@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Sep 30, 2008 at 12:02:57AM +0300, Roni Feldman wrote:
> Hey Paul,
> 
> The code only supplies a transfer mechanism, that is - a way to start
> it and a way to be notified when it ends. If I'm not mistaken the
> PCI-DMA mapping thing is supposed to behave like any other DMA
> mechanism in the system. You just use pci_map_*, do a transfer, and
> then pci_unmap_* it. That's what I do in my code, at least.
> 
Yes, but the actual user of this code is missing from your patch, which
is why I was wondering how you were attempting to use it. If you can post
the patch for that also, then we can look at what needs to be done for
tying it in generically.
