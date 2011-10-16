From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Date: Sun, 16 Oct 2011 23:50:58 +0000
Subject: Re: [PATCH v2] sh: Take into account the base of System RAM in virt_to_phys()
Message-Id: <CABMQnV+zxWggFnxjVjy0kvk+r4a+kmSXyma5iPTQua0peq-UxQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1317603918-30762-1-git-send-email-horms@verge.net.au>
In-Reply-To: <1317603918-30762-1-git-send-email-horms@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi,

2011/10/13 Simon Horman <horms@verge.net.au>:
> On Wed, Oct 12, 2011 at 05:24:23PM +0900, Magnus Damm wrote:
>> On Mon, Oct 3, 2011 at 10:05 AM, Simon Horman <horms@verge.net.au> wrote:
>> > Previously virt_to_phys() assumed that physical memory always started
>> > at address 0. This is not always the case.
>> >
>> > Tested on an sh7757lcr (32bit system) whose only System RAM region is
>> > 40000000-4effffff and an ecovec24 (29bit system).
>> >
>> > Signed-off-by: Simon Horman <horms@verge.net.au>
>> >
>> > ---
>> > =A0kexec/arch/sh/kexec-sh.c | =A0 45 +++++++++++++++++++++++++++++++++=
+++++++++++-
>> > =A01 files changed, 44 insertions(+), 1 deletions(-)
>> >
>> > v2
>> > * Only use the base of System RAM as an offset into physical memory
>> > =A0if 32bit addressing is in use.
>>
>> This version looks much better, thanks!
>
> I thought so too. But after pushing it I realised the parsing logic in
> is_32bit() is flawed. I will send an update.


yes, line of sscan does not work.
I think that the following is good if I easily make modifications.

while(fgets(line, sizeof(line), fp) !=3D 0) {
    if (!strcmp(line, "address sizes\t: 32 bits physical\n"))  {
        status =3D 1;
        break;
    }
}

Best regards,
  Nobuhiro


--=20
Nobuhiro Iwamatsu
