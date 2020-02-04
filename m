From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Tue, 04 Feb 2020 06:52:37 +0000
Subject: Re: [PATCH 0/3] dmaengine: Stear users towards dma_request_slave_chan()
Message-Id: <b09ad222-f5b8-af5a-6c2b-2dd6b30f1c73@ti.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20200203101806.2441-1-peter.ujfalusi@ti.com>
 <CAHp75Vf__isc59YBS9=O+9ApSV62XuZ2nBAWKKD_K7i72P-yFg@mail.gmail.com>
 <e47927aa-8d40-aa71-aef4-5f9c4cbbc03a@ti.com>
 <CAHp75Vd1A+8N_RPq3oeoXS19XeFtv7YK69H5XfzLMxWyCHbzBQ@mail.gmail.com>
 <701ab186-c240-3c37-2c0b-8ac195f8073f@ti.com>
 <CAMuHMdUYRvjR5qe5RVzggN+BaHw8ObEtnm8Kdn25XUiv2sJpPg@mail.gmail.com>
 <38f686ae-66fa-0e3a-ec2e-a09fc4054ac4@physik.fu-berlin.de>
 <CAMuHMdXahPt4q7Dd-mQ9RNr7JiCt8PhXeT5U2D+n-ngJmEQMgw@mail.gmail.com>
In-Reply-To: <CAMuHMdXahPt4q7Dd-mQ9RNr7JiCt8PhXeT5U2D+n-ngJmEQMgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Geert Uytterhoeven <geert@linux-m68k.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Vinod Koul <vkoul@kernel.org>, dmaengine <dmaengine@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Dan Williams <dan.j.williams@intel.com>, Linux-sh list <linux-sh@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

Hi Geert, Adrian,

On 03/02/2020 22.34, Geert Uytterhoeven wrote:
> Hi Adrian,
>=20
> On Mon, Feb 3, 2020 at 9:21 PM John Paul Adrian Glaubitz
> <glaubitz@physik.fu-berlin.de> wrote:
>> On 2/3/20 2:32 PM, Geert Uytterhoeven wrote:
>>> Both rspi and sh-msiof have users on legacy SH (i.e. without DT):
>>
>> FWIW, there is a patch set by Yoshinori Sato to add device tree support
>> for classical SuperH hardware. It was never merged, unfortunately :(.
>=20
> True.
>=20
>>> Anyone who cares for DMA on SuperH?
>>
>> What is DMA used for on SuperH? Wouldn't dropping it cut support for
>> essential hardware features?
>=20
> It may make a few things slower.

I would not drop DMA support but I would suggest to add dma_slave_map
for non DT boot so the _compat() can be dropped.

Imho on lower spec SoC (and I believe SuperH is) the DMA makes big
difference offloading data movement from the CPU.

> Does any of your SuperH boards use DMA?
> Anything interesting in /proc or /sys w.r.t. DMA?
>=20
> Gr{oetje,eeting}s,
>=20
>                         Geert
>=20

- P=C3=A9ter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
