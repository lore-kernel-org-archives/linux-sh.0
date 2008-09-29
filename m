From: "Roni Feldman" <ronifeldman@gmail.com>
Date: Mon, 29 Sep 2008 21:02:57 +0000
Subject: Re: [RFC] sh7751(r): Adding support for PCI-DMA
Message-Id: <7b5883fc0809291402l17272172se90533ad2ebdd12c@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <7b5883fc0809260450w642dde94k1c25166d8305f007@mail.gmail.com>
In-Reply-To: <7b5883fc0809260450w642dde94k1c25166d8305f007@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hey Paul,

The code only supplies a transfer mechanism, that is - a way to start
it and a way to be notified when it ends. If I'm not mistaken the
PCI-DMA mapping thing is supposed to behave like any other DMA
mechanism in the system. You just use pci_map_*, do a transfer, and
then pci_unmap_* it. That's what I do in my code, at least.

On Mon, Sep 29, 2008 at 2:49 PM, Paul Mundt <lethal@linux-sh.org> wrote:
> On Fri, Sep 26, 2008 at 02:50:10PM +0300, Roni Feldman wrote:
>> I've added very basic PCI-DMA support for the sh7751's. I'll be happy
>> to see if this works on different machines since it has been tested
>> only on one platform.  Also, it would be interesting to know if there
>> are other SH-4(A) devices that support this.
>>
> Before really being able to comment on this, how exactly are you
> attempting to use this exposed API? Are you attempting to tie this in to
> the DMA mapping ops?
>
