From: Benoit Cousson <bcousson@baylibre.com>
Date: Thu, 05 Jun 2014 07:01:38 +0000
Subject: Re: [PATCH v2 0/8] ARM: shmobile: Enable CPU FREQ support
Message-Id: <539015D2.7040301@baylibre.com>
List-Id: <linux-sh.vger.kernel.org>
References: <538DB936.9020003@bp.renesas.com>
In-Reply-To: <538DB936.9020003@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi Inami-san and Magnus,

On 04/06/2014 14:13, Magnus Damm wrote:
> Hi Inami-san, everyone,
>
> On Tue, Jun 3, 2014 at 9:01 PM, Gaku Inami <gaku.inami.xw@bp.renesas.com>=
 wrote:
>> This patch series is initial support for CPU FREQ.
>>
>> Based on : renesas-devel-v3.15-rc7-20140530
>>
>> Support :
>>   [CPU]
>>   - Coretex A15( Z clock) : Supported
>>   - Coretex A7 (Z2 clock) : Not supported
>>   [HW]
>>   - R-CAR H2(ES1.0) : Not supported
>>   - R-CAR H2(ES2.0) : Supported
>>   - R-CAR M2(ES1.0) : Supported
>>   - R-CAR M2(ES2.0) : Supported
>>   - Other HW : Not supported
>>   [DVFS feature]
>>   - DFS : Supported
>>   - DVS : Not supported
>>
>> Changes since version 1:
>>   - changed "Signed-off-by" and "From" correctly.
>>   - added DA9210 regulator.
>>   - changed the setting of OPPs for R-CAR H2(ES2.0).
>>   - changed the method of checking the device tree.
>>   - changed the setting of Vmin for disabling DVS
>>   - fixed subject.
>>   - fixed typo.
>>
>> Benoit Cousson (3):
>>    ARM: shmobile: lager: Add VDD MPU regulator for DVFS
>>    ARM: shmobile: r8a7790/lager dts: Add DVFS parameters into cpu0 node
>>      for r8a7790
>>    ARM: shmobile: Make r8a7790 CPUFreq capable
>>
>> Gaku Inami (5):
>>    ARM: shmobile: add cpufreq-cpu0 driver for common SH-Mobile
>>    ARM: shmobile: koelsch dts: Add VDD MPU regulator for DVFS
>>    ARM: shmobile: r8a7791/koelsch dts: Add DVFS parameters into cpu0
>>      node for r8a7791
>>    ARM: shmobile: Make r8a7791 CPUFreq capable
>>    ARM: shmobile: Enable CPUFREQ configuration
>
> Many thanks for these patches to both Benoit and Inami-san.

Thanks a lot for taking care of my series and extending it to other=20
Soc/board.

Magnus,
Thanks for the acks.

Regards,
Benoit

--=20
Beno=C3=AEt Cousson
BayLibre
Embedded Linux Technology Lab
www.baylibre.com
