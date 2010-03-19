From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 19 Mar 2010 04:58:25 +0000
Subject: Re: Trouble with embedding initial root fs into the kernel
Message-Id: <aec7e5c31003182158o58976fa4y398cc7e74b1fb29d@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201003161222.05067.fabio.giovagnini@aurion-tech.com>
In-Reply-To: <201003161222.05067.fabio.giovagnini@aurion-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Mar 19, 2010 at 6:07 AM, Fabio Giovagnini
<fabio.giovagnini@aurion-tech.com> wrote:
> Wher do I have to include the script creating the nodes?

It depends on your user space setup.

I'm using busybox with init enabled together with the following line
in my /etc/inittab:

::sysinit:/etc/init.d/rcS

The file /etc/init.d/rcS looks like this:
#!/bin/sh

# sysfs is mandatory
mount -t sysfs none /sys

# optional filesystem support
mount -t proc none /proc
mount -t tmpfs none /tmp

# use tmpfs for /dev
mount -t tmpfs -o sizedk,mode55 tmpfs /dev

# optional /dev/pts filesystem support
mkdir -p /dev/pts
mount -t devpts none /dev/pts

# setup mdev as hotplug handler
if [ -f /proc/sys/kernel/hotplug ]; then
  echo /sbin/mdev > /proc/sys/kernel/hotplug
else
  /sbin/sysctl -w kernel.hotplug=/sbin/mdev
fi

# udev replacement
mdev -s

# setup local network interface
ifconfig lo 127.0.0.1 up
