From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 04 Sep 2014 11:04:04 +0000
Subject: Re: [PATCH] ARM: shmobile: lager: Remove legacy C board code
Message-Id: <CANqRtoQmDBcM19KV1KrM8Kc1RFbY5zjAPodX5_Zhj01ZnOoHLQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20140904023440.26241.39089.sendpatchset@w520>
In-Reply-To: <20140904023440.26241.39089.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Laurent,

On Thu, Sep 4, 2014 at 3:48 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Hi Magnus,
>
> Thank you for the patch.
>
> On Thursday 04 September 2014 11:34:40 Magnus Damm wrote:
>> From: Magnus Damm <damm+renesas@opensource.se>
>>
>> The Multiplatform r8a7790 Lager board code is at this point
>> in equally or better state compared to the legacy code.
>
> Don't we miss support for USBHS and sound with multiplatform Lager ? Did you
> maybe mean to remove the Koelsch legacy board code ?

I intend to remove both sooner or later, also including defconfigs.

But yes, DMA enabled sound is not yet there. And some USB bits.

It also collides with your DU DT patch series. How do we order all
this, perhaps a discussion to have with Simon?

Cheers,

/ magnus
