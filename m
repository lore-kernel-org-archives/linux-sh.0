From: Violeta Menendez Gonzalez <violeta.menendez@codethink.co.uk>
Date: Thu, 05 Jun 2014 09:10:05 +0000
Subject: Re: [alsa-devel] r8a7790 only has audio when clock is forced on
Message-Id: <539033ED.4010604@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <538E0487.1010700@codethink.co.uk>	<20140603214226.GA2520@sirena.org.uk>	<87egz5ldtm.wl%kuninori.morimoto.gx@renesas.com>	<538EE0BE.5030304@codethink.co.uk> <87zjhrj3gc.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87zjhrj3gc.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Ben Dooks <ben.dooks@codethink.co.uk>
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@lists.codethink.co.uk, ALSA Development Mailing List <alsa-devel@alsa-project.org>, linux-sh@vger.kernel.org

Hi!

On 06/05/14 07:05, Kuninori Morimoto wrote:
>
> Hi Ben
>
> # I misunderstood your point...
>
>> The result of our investigation is as follows:
>>
>> - The clock code correctly enables SSI(ALL) but the audio does not work
>> - If we force SSI(ALL) to be on all the time, we have working audio
>
> SSI(ALL) bit mean "this bit is always required for all SSI"
> If you want to use SSI0, then, you need to enable "SSI(ALL) + SSI0" bit
>

We have to force SSI(ALL) to stay always on on the DT with a special=20
property, like this:
always-on =3D <0x00000020>;

we don't need to force SSI0 on, although it is necessary for audio that=20
this clock is on too.

The code for mstp10 correctly enables SSI0 *and* SSI(ALL). But it only=20
works when SSI(ALL) is forced on the DT.

When we do on the DT: always-on =3D <0x00000020>;
we have:
cpg_mstp_clock_endisable: index 5, enable 0
cpg_mstp_clock_endisable: index 5, value read from group->smstpcr 0002ffc0
cpg_mstp_clock_endisable: index 5, value write in group->smstpcr 0002ffc0
cpg_mstp_clock_endisable: index 5, enable 1
cpg_mstp_clock_endisable: index 5, value read from group->smstpcr 0002ffc0
cpg_mstp_clock_endisable: index 5, value write in group->smstpcr 0002ffc0
cpg_mstp_clock_endisable: index 15, enable 1
cpg_mstp_clock_endisable: index 15, value read from group->smstpcr 0002ffc0
cpg_mstp_clock_endisable: index 15, value write in group->smstpcr 00027fc0
cpg_mstp_clock_endisable: index 15, enable 0
cpg_mstp_clock_endisable: index 15, value read from group->smstpcr 00027fc0
cpg_mstp_clock_endisable: index 15, value write in group->smstpcr 0002ffc0
cpg_mstp_clock_endisable: index 5, enable 0
cpg_mstp_clock_endisable: index 5, value read from group->smstpcr 0002ffc0
cpg_mstp_clock_endisable: index 5, value write in group->smstpcr 0002ffc0
and audio is working correctly.

If we do: always-on =3D <0x00000000>; (or not having the property at all)
then we have:
cpg_mstp_clock_endisable: index 5, enable 1
cpg_mstp_clock_endisable: index 5, value read from group->smstpcr 0002ffe0
cpg_mstp_clock_endisable: index 5, value write in group->smstpcr 0002ffc0
cpg_mstp_clock_endisable: index 15, enable 1
cpg_mstp_clock_endisable: index 15, value read from group->smstpcr 0002ffc0
cpg_mstp_clock_endisable: index 15, value write in group->smstpcr 00027fc0
cpg_mstp_clock_endisable: index 15, enable 0
cpg_mstp_clock_endisable: index 15, value read from group->smstpcr 00027fc0
cpg_mstp_clock_endisable: index 15, value write in group->smstpcr 0002ffc0
cpg_mstp_clock_endisable: index 5, enable 0
cpg_mstp_clock_endisable: index 5, value read from group->smstpcr 0002ffc0
cpg_mstp_clock_endisable: index 5, value write in group->smstpcr 0002ffe0
and we don't have audio at all.

Where index 5 is SSI(ALL) and index 15 is SSI0.
We can observe that when we force SSI(ALL) on on the DT, then=20
clock_disable is called for SSI(ALL) before it enables again.
But when we don't force SSI(ALL) to be on, then it only calls=20
clock_enable, but the register data is the same.

This looks like the correct behaviour, but in one case we have audio,=20
and in the other we don't.

I hope this clarifies the problem a bit more.

Thanks

--=20
Violeta Men=E9ndez Gonz=E1lez	http://www.codethink.co.uk/
Software Engineer		Codethink - Providing Genius
