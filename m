From: Rob Landley <rob@landley.net>
Date: Tue, 04 Feb 2020 10:18:06 +0000
Subject: Re: [PATCH 0/3] dmaengine: Stear users towards dma_request_slave_chan()
Message-Id: <3601f6ef-1666-2fd5-263c-388c0c48db16@landley.net>
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
 <64cffbfe-a639-c09d-8aa2-fdda8fad2cf7@landley.net>
 <CAMuHMdVeCaRu=D9stdEuWKpnVm1YBibwuVrxogVx+2RBvOb1tA@mail.gmail.com>
In-Reply-To: <CAMuHMdVeCaRu=D9stdEuWKpnVm1YBibwuVrxogVx+2RBvOb1tA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Andy Shevchenko <andy.shevchenko@gmail.com>, Vinod Koul <vkoul@kernel.org>, dmaengine <dmaengine@vger.kernel.org>, Dan Williams <dan.j.williams@intel.com>, Linux-sh list <linux-sh@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

On 2/4/20 3:27 AM, Geert Uytterhoeven wrote:
> Hi Rob,
> 
> On Tue, Feb 4, 2020 at 10:12 AM Rob Landley <rob@landley.net> wrote:
>> On 2/4/20 2:01 AM, Geert Uytterhoeven wrote:
>>> On Tue, Feb 4, 2020 at 7:52 AM Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
>>>> On 03/02/2020 22.34, Geert Uytterhoeven wrote:
>>>>> On Mon, Feb 3, 2020 at 9:21 PM John Paul Adrian Glaubitz
>>>>> <glaubitz@physik.fu-berlin.de> wrote:
>>>>>> On 2/3/20 2:32 PM, Geert Uytterhoeven wrote:
>>>>>>> Both rspi and sh-msiof have users on legacy SH (i.e. without DT):
>>>>>>
>>>>>> FWIW, there is a patch set by Yoshinori Sato to add device tree support
>>>>>> for classical SuperH hardware. It was never merged, unfortunately :(.

The problem with converting everything else to j-core has always been regression
testing. I have 2 pieces of classing sh4 hardware, and one classing sh2 board,
and none of them are currently on the same continent I am. :)

(I've got 3 different j-core boards, though. And am currently in the same room
as 2 others. :)

>>>>> True.
>>>>>
>>>>>>> Anyone who cares for DMA on SuperH?
>>>>>>
>>>>>> What is DMA used for on SuperH? Wouldn't dropping it cut support for
>>>>>> essential hardware features?
>>>>>
>>>>> It may make a few things slower.
>>
>> The j-core stuff has DMA but we haven't hooked it up to dmaengine yet. (It's on
>> the todo list but pretty far down.)
> 
> And would use DT.  Hence the issue is not applicable to j-core.

Indeed.

The last classic sh4 board I used did not have DMA hooked up in Linux, and
trying to make current kernels work hit the fact that the device tree people
kept breaking various pre-device tree APIs, and my patches to fix them were met
with "you should convert everything to device tree rather than fix this obvious
regression we caused" and thus never went upstream. (Johnson Controls shipped
them locally and I handed the patches over to the lawyers to do the license
compliance tarball before I left. And of course I posted the fixes to this list...)

It's nice that at least this time somebody is _asking_ before breaking
non-device-tree support for stuff that used to work...

>> The turtle boards need it USB, ethernet, and sdcard, but Rich Felker hasn't
>> finished the j32 port yet (we just got him the updated docs last month) and the
>> existing implementation is nommu so the things that are using it are reaching
>> around behind the OS's back...
> 
> Is j32 the (rebranded) j4?

Yes.

Rob
