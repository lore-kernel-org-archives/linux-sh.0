From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 13 Apr 2015 20:49:40 +0000
Subject: Re: [PATCH v2] Renesas Ethernet AVB driver
Message-Id: <552C2BE4.7010804@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1453213.DoV6WFn45r@wasted.cogentembedded.com> <20150413.163259.2190743529898270341.davem@davemloft.net>
In-Reply-To: <20150413.163259.2190743529898270341.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: David Miller <davem@davemloft.net>
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, devicetree@vger.kernel.org, galak@codeaurora.org, netdev@vger.kernel.org, richardcochran@gmail.com, linux-sh@vger.kernel.org

Hello.

On 04/13/2015 11:32 PM, David Miller wrote:

>> Ethernet AVB includes an Gigabit Ethernet controller (E-MAC) that is bas=
ically
>> compatible with SuperH Gigabit Ethernet E-MAC). Ethernet AVB  has a dedi=
cated
>> direct memory access controller (AVB-DMAC) that is a new design compared=
 to the
>> SuperH E-DMAC. The AVB-DMAC is compliant with 3 standards formulated for=
 IEEE
>> 802.1BA: IEEE 802.1AS timing and synchronization protocol, IEEE 802.1Qav=
 real-
>> time transfer, and the IEEE 802.1Qat stream reservation protocol.

>> Not only the Ethernet driver is enclosed, there is also the PTP driver in
>> the same file.  These drivers only support device tree probing, so the b=
inding
>> document is included in this patch.

>> Based on the original patches by Mitsuhiro Kimura (Ethernet driver) and =
Masaru
>> Nagai (PTP driver).

>> Signed-off-by: Mitsuhiro Kimura <mitsuhiro.kimura.kc@renesas.com>
>> Signed-off-by: Masaru Nagai <masaru.nagai.vx@renesas.com>
>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

> Doesn't build properly on x86-64:

>    CC [M]  drivers/net/ethernet/renesas/ravb.o
> drivers/net/ethernet/renesas/ravb.c: In function =A1ravb_set_buffer_align=
=A2:
> drivers/net/ethernet/renesas/ravb.c:955:16: warning: cast from pointer to=
 integer of different size [-Wpointer-to-int-cast]
>    u32 reserve =3D (u32)skb->data & (RAVB_ALIGN - 1);
>                  ^
> drivers/net/ethernet/renesas/ravb.c: At top level:
> drivers/net/ethernet/renesas/ravb.c:2771:2: error: unknown field =A1getti=
me=A2 specified in initializer
>    .gettime =3D ravb_ptp_gettime,
>    ^
> drivers/net/ethernet/renesas/ravb.c:2772:2: error: unknown field =A1setti=
me=A2 specified in initializer
>    .settime =3D ravb_ptp_settime,
>    ^

    So, timespec64 patches have been merged to net-next... In my haste I ju=
st=20
forgot to compile-test the driver in net-next, sorry about that. :-<

> It is not acceptable to fix this by removing COMPILE_TEST from the Kconfig
> dependencies or something like that.

    It's also impossible as the errors themselves don't depend on ARCH. :-)

> Thanks.

WBR, Sergei

