From: Conrad Parker <conrad@metadecks.org>
Date: Thu, 18 Mar 2010 00:25:35 +0000
Subject: Re: nfsroot is to slow
Message-Id: <dba6c0831003171725n344162d1m96902fe0618a90ee@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201003171728.25305.fabio.giovagnini@aurion-tech.com>
In-Reply-To: <201003171728.25305.fabio.giovagnini@aurion-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 18 March 2010 01:28, Fabio Giovagnini
<fabio.giovagnini@aurion-tech.com> wrote:
> Hi all,
> now I'm able to mount root nfs but it is so slow:
> /dev/root,0x0c1a58a0,0x00008000,0x0c24659c
> do_mount_root,273 - debug 2
> do_mount_root,277 - debug 3
> do_mount_root,279 - debug 4
> VFS: Mounted root (nfs filesystem).
> Freeing unused kernel memory: 88k freed
> nfs: server 192.168.1.2 not responding, still trying
> nfs: server 192.168.1.2 OK
> nfs: server 192.168.1.2 not responding, still trying
> nfs: server 192.168.1.2 not responding, still trying
>
> I can see this.
> Where can I investigate.
> Server side or my board side?

Is this with a current kernel?

Conrad.
