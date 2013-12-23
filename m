From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 23 Dec 2013 14:10:09 +0000
Subject: Re: [PATCH 2/3] ARM: shmobile: kzm9g: add FSI support for DTS
Message-Id: <52B84441.2020809@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1387764079.git.horms+renesas@verge.net.au>
 <3c2a87c85391272b098827e432813c9437e93992.1387764079.git.horms+renesas@verge.net.au>
 <52B838C1.1080705@cogentembedded.com>
In-Reply-To: <52B838C1.1080705@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello.

On 23-12-2013 17:21, Sergei Shtylyov wrote:

>> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

>> This patch support FSI-AK4648 with simple audio card

>> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
>> ---
>>   arch/arm/boot/dts/sh73a0-kzm9g-reference.dts | 33
>> ++++++++++++++++++++++++++++
>>   1 file changed, 33 insertions(+)

>> diff --git a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
>> b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
>> index 5bb593d..eb8886b 100644
>> --- a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
>> +++ b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
> [...]
>> @@ -226,6 +240,12 @@
>>               };
>>           };
>>       };
>> +
>> +    ak4648: ak4648@0x12 {

>     Perhaps "sound-codec" or "audio-codec" would be a better name; hardware
> specific names are not recommended by ePAPR. And drop "0x" from the address
> part please.

    Sorry, I didn't notice the patch is posted as a part of pull request; I've 
probably missed the original posting (though I've already told to Morimoto-san 
that names like "ak4648" shouldn't be used).

WBR, Sergei

