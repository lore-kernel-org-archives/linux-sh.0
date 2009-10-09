From: Dale Larson <dlarson42@gmail.com>
Date: Fri, 09 Oct 2009 12:45:48 +0000
Subject: Can't Pull or Clone the SH Repository
Message-Id: <6e6aa1a80910090545i78523b6dve67760086088acff@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

I can't seem to get full access to the:

http://www.kernel.org/pub/scm/linux/kernel/git/lethal/sh-2.6.git

repository.

A clone yields:
----------
dlarson@UbuntuDale:~/scm/git$ git clone
http://www.kernel.org/pub/scm/linux/kernel/git/lethal/sh-2.6.git
sh-2.6.git
Initialized empty Git repository in /home/dlarson/scm/git/sh-2.6.git/.git/
Cannot get remote repository information.
Perhaps git-update-server-info needs to be run there?
----------

A pull or fetch from an already existing clone yields:
----------
dlarson@UbuntuDale:~/scm/git/linux-sh-2.6.git$ git branch
* cachetlb
  for-2.6.30
  master
dlarson@UbuntuDale:~/scm/git/linux-sh-2.6.git$ git pull
error: Failed connect to www.kernel.org:80; Operation now in progress
error: Failed connect to www.kernel.org:80; Operation now in progress
You asked me to pull without telling me which branch you
want to merge with, and 'branch.cachetlb.merge' in
your configuration file does not tell me either.  Please
name which branch you want to merge on the command line and
try again (e.g. 'git pull <repository> <refspec>').
See git-pull(1) for details on the refspec.

If you often merge with the same branch, you may want to
configure the following variables in your configuration
file:

    branch.cachetlb.remote = <nickname>
    branch.cachetlb.merge = <remote-ref>
    remote.<nickname>.url = <url>
    remote.<nickname>.fetch = <refspec>

See git-config(1) for details.
dlarson@UbuntuDale:~/scm/git/linux-sh-2.6.git$ git fetch
error: Failed connect to www.kernel.org:80; Operation now in progress
error: Failed connect to www.kernel.org:80; Operation now in progress
----------

I've been using the http protocol version rather than the git protocol
because I have to work through an authenticated http proxy firewall.

Anyone have an idea for fixing this?

Dale Larson
Johnson Controls, Inc
