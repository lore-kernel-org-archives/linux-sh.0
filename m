From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 11 Jun 2012 05:02:16 +0000
Subject: Re: [PATCH 2/2] irqdomain: Support for static IRQ mapping and association.
Message-Id: <CACxGe6sRVk3sef0X9Q_FDcMx5=y0mKJ-pUM-S2-CitUFQ7koGA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1337576792-5347-1-git-send-email-lethal@linux-sh.org>
 <1337576792-5347-2-git-send-email-lethal@linux-sh.org> <20120526015049.1616D3E2336@localhost>
 <20120611032547.GB10170@linux-sh.org>
In-Reply-To: <20120611032547.GB10170@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Paul Mundt <lethal@linux-sh.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, Jun 10, 2012 at 9:25 PM, Paul Mundt <lethal@linux-sh.org> wrote:
> On Fri, May 25, 2012 at 07:50:49PM -0600, Grant Likely wrote:
>> On Mon, 21 May 2012 14:06:32 +0900, Paul Mundt <lethal@linux-sh.org> wro=
te:
>> > +int irq_create_strict_mappings(struct irq_domain *domain, unsigned in=
t irq_base,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0irq_hw_number_t h=
wirq_base, int count)
>> > +{
>> > + =A0 int ret;
>> > +
>> > + =A0 ret =3D irq_alloc_descs(irq_base, irq_base, count,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_node_to_nid(domai=
n->of_node));
>> > + =A0 if (unlikely(ret < 0))
>> > + =A0 =A0 =A0 =A0 =A0 return ret;
>> > +
>> > + =A0 ret =3D irq_domain_associate_many(domain, irq_base, hwirq_base, =
count);
>> > + =A0 if (unlikely(ret < 0)) {
>> > + =A0 =A0 =A0 =A0 =A0 irq_free_descs(irq_base, count);
>> > + =A0 =A0 =A0 =A0 =A0 return ret;
>> > + =A0 }
>>
>> It would be really good to make sure the hwirqs aren't already
>> associated before trying to associate them again. =A0Unfortunately that
>> can't be done (nicely) until I get rid of the slow path lookup. =A0I've
>> got a patch for that which I'll rebase on top of this one and post soon.
>>
> Any updates on this? I have quite a few more changes I intend on making,
> but there's no point in starting in on that until these existing patches
> are sorted out.

Yeah, I made some progress and have a whole bunch of patches to post
which I had hoped to do last week.  Unfortunately the move to the UK
has meant that the last 7 days have been non-stop cleaning, packing
and throwing out stuff.  I've not been able to do a final cleanup.
The house gets cleaned on Tuesday so it can go on the market on
Wednesday which means all the house stuff must be done by Monday
evening.  Hopefully I'll get some time on Tuesday to do some hacking.

If you want to look at them I've pushed them out to the irqdomain/test
branch on git.secretlab.ca.

g.
