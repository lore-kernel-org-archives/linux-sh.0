From: Simon Boulay <simon.boulay@gmail.com>
Date: Thu, 18 Mar 2010 07:38:22 +0000
Subject: Re: nfsroot is to slow
Message-Id: <8809f7c51003180038if504b7axbe8ddddeefe02e8a@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201003171728.25305.fabio.giovagnini@aurion-tech.com>
In-Reply-To: <201003171728.25305.fabio.giovagnini@aurion-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-sh@vger.kernel.org

On Thu, Mar 18, 2010 at 7:11 AM, Fabio Giovagnini
<fabio.giovagnini@aurion-tech.com> wrote:
> No it isn't.
> it is linux 2.6.17.
> I'm tring to pass to tne newest, but now I have to finish my ampplication with
> this configuration.
>
> I read this:
> TCP bic registered
> IP-Config: Complete:
>      device=eth0, addr2.168.1.3, mask%5.255.255.0, gw2.168.1.254,
>     host=uclinux, domain=, nis-domain=(none),
>     bootserver2.168.1.2, rootserver2.168.1.2, rootpath> Looking up port of RPC 100003/3 on 192.168.1.2
> Looking up port of RPC 100005/3 on 192.168.1.2
> do_mount_root,270 - debug 1
> /dev/root,0x0c1a58a0,0x00008000,0x0c24659c
> do_mount_root,273 - debug 2
> do_mount_root,277 - debug 3
> do_mount_root,279 - debug 4
> VFS: Mounted root (nfs filesystem).
> Freeing unused kernel memory: 88k freed
> Warning: unable to open an initial console.
> Kernel panic - not syncing: No init found.  Try passing init= option to
> kernel.
>
>
> Could be rootpath=<empty>
> the problem?
Yes, it could. If it's not a typo error in your mail, the right syntax
for the nfsroot parameter is:
nfsroot2.168.1.2:/home/fgiovagnini/nfsroot,v3,tcp
(note the ':')

Cheers,
Simon.


> Thanks
>
>
> In data giovedě 18 marzo 2010 01:25:35, Conrad Parker ha scritto:
> : > On 18 March 2010 01:28, Fabio Giovagnini
>>
>> <fabio.giovagnini@aurion-tech.com> wrote:
>> > Hi all,
>> > now I'm able to mount root nfs but it is so slow:
>> > /dev/root,0x0c1a58a0,0x00008000,0x0c24659c
>> > do_mount_root,273 - debug 2
>> > do_mount_root,277 - debug 3
>> > do_mount_root,279 - debug 4
>> > VFS: Mounted root (nfs filesystem).
>> > Freeing unused kernel memory: 88k freed
>> > nfs: server 192.168.1.2 not responding, still trying
>> > nfs: server 192.168.1.2 OK
>> > nfs: server 192.168.1.2 not responding, still trying
>> > nfs: server 192.168.1.2 not responding, still trying
>> >
>> > I can see this.
>> > Where can I investigate.
>> > Server side or my board side?
>>
>> Is this with a current kernel?
>>
>> Conrad.
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
> --
> Fabio Giovagnini
>
> Aurion s.r.l.
> P.I e C.F.
> 00885711200
> Tel. +39.051.594.78.24
> Cell. +39.335.83.50.919
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
