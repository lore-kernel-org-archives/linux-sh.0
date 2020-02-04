From: Rob Landley <rob@landley.net>
Date: Tue, 04 Feb 2020 09:16:58 +0000
Subject: Re: [PATCH 0/3] dmaengine: Stear users towards dma_request_slave_chan()
Message-Id: <64cffbfe-a639-c09d-8aa2-fdda8fad2cf7@landley.net>
List-Id: <linux-sh.vger.kernel.org>
References: <20200203101806.2441-1-peter.ujfalusi@ti.com>
 <CAHp75Vf__isc59YBS9=O+9ApSV62XuZ2nBAWKKD_K7i72P-yFg@mail.gmail.com>
 <e47927aa-8d40-aa71-aef4-5f9c4cbbc03a@ti.com>
 <CAHp75Vd1A+8N_RPq3oeoXS19XeFtv7YK69H5XfzLMxWyCHbzBQ@mail.gmail.com>
 <701ab186-c240-3c37-2c0b-8ac195f8073f@ti.com>
 <CAMuHMdUYRvjR5qe5RVzggN+BaHw8ObEtnm8Kdn25XUiv2sJpPg@mail.gmail.com>
 <38f686ae-66fa-0e3a-ec2e-a09fc4054ac4@physik.fu-berlin.de>
 <CAMuHMdXahPt4q7Dd-mQ9RNr7JiCt8PhXeT5U2D+n-ngJmEQMgw@mail.gmail.com>
 <b09ad222-f5b8-af5a-6c2b-2dd6b30f1c73@ti.com>
 <CAMuHMdUYcSPoK8NOSdMzU_Jtg84aPMNKeGnacnF7=aidV4eqvw@mail.gmail.com>
In-Reply-To: <CAMuHMdUYcSPoK8NOSdMzU_Jtg84aPMNKeGnacnF7=aidV4eqvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Andy Shevchenko <andy.shevchenko@gmail.com>, Vinod Koul <vkoul@kernel.org>, dmaengine <dmaengine@vger.kernel.org>, Dan Williams <dan.j.williams@intel.com>, Linux-sh list <linux-sh@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

On 2/4/20 2:01 AM, Geert Uytterhoeven wrote:
> Hi Peter,
> 
> On Tue, Feb 4, 2020 at 7:52 AM Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
>> On 03/02/2020 22.34, Geert Uytterhoeven wrote:
>>> On Mon, Feb 3, 2020 at 9:21 PM John Paul Adrian Glaubitz
>>> <glaubitz@physik.fu-berlin.de> wrote:
>>>> On 2/3/20 2:32 PM, Geert Uytterhoeven wrote:
>>>>> Both rspi and sh-msiof have users on legacy SH (i.e. without DT):
>>>>
>>>> FWIW, there is a patch set by Yoshinori Sato to add device tree support
>>>> for classical SuperH hardware. It was never merged, unfortunately :(.
>>>
>>> True.
>>>
>>>>> Anyone who cares for DMA on SuperH?
>>>>
>>>> What is DMA used for on SuperH? Wouldn't dropping it cut support for
>>>> essential hardware features?
>>>
>>> It may make a few things slower.

The j-core stuff has DMA but we haven't hooked it up to dmaengine yet. (It's on
the todo list but pretty far down.)

I fought with dmaengine in a 7760 board in 2018, and got it to run its tests but
the ship deadline arrived before I got the ethernet working with it.

I found the documentation fairly impenetrable, is there a good primer on what's
_current_ for new implementations? (I had similar questions for gpio. It's easy
to google for "here's how you did it in 2010"...)

>> I would not drop DMA support but I would suggest to add dma_slave_map
>> for non DT boot so the _compat() can be dropped.
> 
> Which is similar in spirit to gpiod_lookup and clk_register_clkdev(),
> right?
> 
>> Imho on lower spec SoC (and I believe SuperH is) the DMA makes big
>> difference offloading data movement from the CPU.
> 
> Assumed it is actually used...

The turtle boards need it USB, ethernet, and sdcard, but Rich Felker hasn't
finished the j32 port yet (we just got him the updated docs last month) and the
existing implementation is nommu so the things that are using it are reaching
around behind the OS's back...

Rob
